// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {AutomationCompatible} from "@chainlink/contracts/src/v0.8/AutomationCompatible.sol";

import {IPriceFeed} from "./interfaces/IPriceFeed.sol";

contract PriceConsumer is IPriceFeed, AutomationCompatible {
    AggregatorV3Interface internal _priceFeed;

    uint256 immutable _interval; // minimum interval (in seconds) between two answers
    uint256 _nextTimestamp;

    int256[] _answers;

    constructor(address priceFeed_, uint256 interval_, uint256 initialTimestamp_, uint80[] memory roundIds_) {
        _priceFeed = AggregatorV3Interface(priceFeed_);
        _interval = interval_;
        _nextTimestamp = initialTimestamp_;

        // seed historical data
        for (uint256 i; i < roundIds_.length; i++) {
            _fetchAnswer(roundIds_[i]);
        }
    }

    function interval() external view returns (uint256) {
        return _interval;
    }

    function nextTimestamp() external view returns (uint256) {
        return _nextTimestamp;
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

        upkeepNeeded = updatedAt >= _nextTimestamp;
        performData = abi.encode(roundId);
    }

    function performUpkeep(bytes calldata performData) external override {
        uint80 roundId = abi.decode(performData, (uint80));
        _fetchAnswer(roundId);
    }

    function _fetchAnswer(uint80 roundId_) internal {
        (, int256 answer,, uint256 updatedAt,) = _priceFeed.getRoundData(roundId_);

        require(updatedAt >= _nextTimestamp, "Answer too old");

        uint256 index = _answers.length;
        _answers.push(answer);
        _nextTimestamp += _interval;

        emit PriceUpdated(index, answer);

        _onAnswer(index, answer);
    }

    function _onAnswer(uint256 index, int256 answer) internal virtual {}
}
