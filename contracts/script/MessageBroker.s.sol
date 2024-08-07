// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Script, console} from "forge-std/Script.sol";

import {MessageBroker} from "../src/MessageBroker.sol";

contract Deploy is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);

        vm.startBroadcast(deployerPrivateKey);

        MessageBroker broker = new MessageBroker(deployer);
        console.log("Message broker deployed at ", address(broker));

        vm.stopBroadcast();
    }
}
