// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Script, console} from "forge-std/Script.sol";

import {UPDWN} from "../src/UPDWN.sol";

contract Deploy is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);

        address rng = vm.envAddress("RNG_CONTRACT_ADDRESS");

        vm.startBroadcast(deployerPrivateKey);

        UPDWN updwn = new UPDWN(deployer, rng, 12);
        console.log("UPDWN deployed at ", address(updwn));

        vm.stopBroadcast();
    }
}
