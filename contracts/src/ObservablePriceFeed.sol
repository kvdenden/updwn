// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {PriceConsumer} from "./PriceConsumer.sol";
import {Publisher} from "./Publisher.sol";

contract ObservablePriceFeed is Publisher, PriceConsumer {
    constructor(
        address broker_,
        address priceFeed_,
        uint256 interval_,
        uint256 initialTimestamp_,
        uint80[] memory roundIds_
    ) Publisher(broker_) PriceConsumer(priceFeed_, interval_, initialTimestamp_, roundIds_) {}

    function _onAnswer(uint256 index, int256 answer) internal virtual override {
        _publish(keccak256("pricefeed.update"), abi.encode(index, answer));
    }
}
