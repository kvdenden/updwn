// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Script} from "forge-std/Script.sol";

import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

contract ScriptBase is Script {
    using Strings for address;

    uint256 public deployerPrivateKey;
    address public deployer;

    function setUp() public {
        deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        deployer = vm.addr(deployerPrivateKey);
    }

    function run() public {
        vm.startBroadcast(deployerPrivateKey);
        _run();
        vm.stopBroadcast();
    }

    function _run() internal virtual {}

    function _setEnv(string memory key, address value) internal {
        vm.setEnv(key, value.toHexString());
    }
}
