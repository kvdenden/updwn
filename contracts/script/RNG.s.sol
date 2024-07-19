// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Script, console} from "forge-std/Script.sol";

import {SimpleRNG} from "../src/SimpleRNG.sol";

contract Deploy is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);

        vm.startBroadcast(deployerPrivateKey);

        SimpleRNG rng = new SimpleRNG(8);
        console.log("SimpleRNG deployed at ", address(rng));

        vm.stopBroadcast();
    }
}
