// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {console} from "forge-std/Script.sol";
import {ScriptBase} from "./Base.sol";

import {SimpleETHTreasury} from "../src/SimpleETHTreasury.sol";
// import {Treasury} from "../src/Treasury.sol";

contract Deploy is ScriptBase {
    function _run() internal override {
        SimpleETHTreasury treasury = new SimpleETHTreasury(deployer);
        console.log("Treasury deployed at ", address(treasury));
        _setEnv("TREASURY_CONTRACT_ADDRESS", address(treasury));
    }
}
