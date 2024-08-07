// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Script, console} from "forge-std/Script.sol";

import {TokenMinter} from "../src/TokenMinter.sol";

contract Deploy is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        // address deployer = vm.addr(deployerPrivateKey);

        address updwn = vm.envAddress("UPDWN_CONTRACT_ADDRESS");
        address treasury = vm.envAddress("TREASURY_CONTRACT_ADDRESS");

        vm.startBroadcast(deployerPrivateKey);

        TokenMinter minter = new TokenMinter(updwn, treasury);
        console.log("Token minter deployed at ", address(minter));

        vm.stopBroadcast();
    }
}
