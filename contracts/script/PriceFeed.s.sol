// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Script, console} from "forge-std/Script.sol";

import {ObservablePriceFeed} from "../src/ObservablePriceFeed.sol";
import {MessageBroker} from "../src/MessageBroker.sol";

contract Deploy is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        // address deployer = vm.addr(deployerPrivateKey);

        address feed = vm.envAddress("PRICE_FEED_ADDRESS");
        uint256 interval = vm.envUint("PRICE_INTERVAL");
        uint256 initialTimestamp = vm.envOr("PRICE_INITIAL_TIMESTAMP", block.timestamp);
        uint80[] memory roundIds = new uint80[](0);

        vm.startBroadcast(deployerPrivateKey);

        MessageBroker broker = MessageBroker(vm.envAddress("MESSAGE_BROKER_CONTRACT_ADDRESS"));

        ObservablePriceFeed priceFeed =
            new ObservablePriceFeed(address(broker), feed, interval, initialTimestamp, roundIds);
        console.log("Price feed deployed at ", address(priceFeed));

        broker.grantRole(broker.PUBLISHER_ROLE(), address(priceFeed));

        vm.stopBroadcast();
    }
}
