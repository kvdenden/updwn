// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {console} from "forge-std/Script.sol";
import {ScriptBase} from "./Base.sol";

import {ObservablePriceFeed} from "../src/ObservablePriceFeed.sol";
import {MessageBroker} from "../src/MessageBroker.sol";

contract Deploy is ScriptBase {
    function _run() internal override {
        address feed = vm.envAddress("PRICE_FEED_ADDRESS");
        uint256 interval = vm.envUint("PRICE_INTERVAL");
        uint256 initialTimestamp = vm.envOr("PRICE_INITIAL_TIMESTAMP", block.timestamp);
        uint80[] memory roundIds = new uint80[](0);

        MessageBroker broker = MessageBroker(vm.envAddress("MESSAGE_BROKER_CONTRACT_ADDRESS"));

        ObservablePriceFeed priceFeed =
            new ObservablePriceFeed(address(broker), feed, interval, initialTimestamp, roundIds);
        console.log("Price feed deployed at ", address(priceFeed));
        _setEnv("PRICE_FEED_CONTRACT_ADDRESS", address(priceFeed));

        broker.grantRole(broker.PUBLISHER_ROLE(), address(priceFeed));
    }
}
