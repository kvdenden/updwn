// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Script, console} from "forge-std/Script.sol";

import {GameEngine} from "../src/GameEngine.sol";
import {MessageBroker} from "../src/MessageBroker.sol";

contract Deploy is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        // address deployer = vm.addr(deployerPrivateKey);

        address updwn = vm.envAddress("UPDWN_CONTRACT_ADDRESS");
        address priceFeed = vm.envAddress("PRICE_FEED_CONTRACT_ADDRESS");
        address treasury = vm.envAddress("TREASURY_CONTRACT_ADDRESS");

        MessageBroker broker = MessageBroker(vm.envAddress("MESSAGE_BROKER_CONTRACT_ADDRESS"));

        vm.startBroadcast(deployerPrivateKey);

        GameEngine game = new GameEngine(updwn, priceFeed, treasury, address(broker));
        console.log("Game engine deployed at ", address(game));

        broker.subscribe(keccak256("pricefeed.update"), address(game));

        vm.stopBroadcast();
    }
}
