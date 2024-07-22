// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {AutomationCompatible} from "@chainlink/contracts/src/v0.8/AutomationCompatible.sol";

import {IPriceFeed} from "./interfaces/IPriceFeed.sol";

contract PriceConsumer is IPriceFeed, AutomationCompatible {
    AggregatorV3Interface internal _priceFeed;

    uint256 public immutable interval; // minimum interval (in seconds) between two answers
    uint256 _nextTimestamp;

    int256[] _answers;

    constructor(address priceFeed, uint256 interval_) {
        _priceFeed = AggregatorV3Interface(priceFeed);
        interval = interval_;
    }

    function getCurrentPrice() external view returns (int256) {
        (, int256 answer,,,) = _priceFeed.latestRoundData();
        return answer;
    }

    function getPrice(uint256 index) external view returns (int256) {
        return _answers[index];
    }

    function priceCount() external view returns (uint256) {
        return _answers.length;
    }

    function checkUpkeep(bytes calldata) external view override returns (bool upkeepNeeded, bytes memory performData) {
        (uint80 roundId,,, uint256 updatedAt,) = _priceFeed.latestRoundData(); // TODO: should we use latest round or find the round right after _nextTimestamp?

        upkeepNeeded = _upkeepAllowed() && updatedAt >= _nextTimestamp;
        performData = abi.encode(roundId);
    }

    function performUpkeep(bytes calldata performData) external override {
        require(_upkeepAllowed(), "Upkeep not allowed yet");

        uint80 roundId = abi.decode(performData, (uint80));
        _fetchAnswer(roundId);
    }

    // TODO: prevent upkeep before historical data is seeded
    function _upkeepAllowed() internal view returns (bool) {
        return _nextTimestamp > 0;
    }

    function _fetchAnswer(uint80 roundId_) internal {
        (, int256 answer,, uint256 updatedAt,) = _priceFeed.getRoundData(roundId_);

        require(updatedAt >= _nextTimestamp, "Not enough time since previous answer");

        uint256 index = _answers.length;
        _answers.push(answer);
        _nextTimestamp += interval;

        emit PriceUpdated(index, answer);

        _onAnswer();
    }

    function _onAnswer() internal virtual {}
}
