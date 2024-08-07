// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Script, console} from "forge-std/Script.sol";

import {SimpleETHTreasury} from "../src/SimpleETHTreasury.sol";
// import {Treasury} from "../src/Treasury.sol";

contract Deploy is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);

        vm.startBroadcast(deployerPrivateKey);

        SimpleETHTreasury treasury = new SimpleETHTreasury(deployer);
        console.log("Treasury deployed at ", address(treasury));

        vm.stopBroadcast();
    }
}
