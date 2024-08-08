// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {console} from "forge-std/Script.sol";
import {ScriptBase} from "./Base.sol";

import {TokenMinter} from "../src/TokenMinter.sol";

contract Deploy is ScriptBase {
    function _run() internal override {
        address updwn = vm.envAddress("UPDWN_CONTRACT_ADDRESS");
        address treasury = vm.envAddress("TREASURY_CONTRACT_ADDRESS");

        TokenMinter minter = new TokenMinter(updwn, treasury);
        console.log("Token minter deployed at ", address(minter));
        _setEnv("TOKEN_MINTER_CONTRACT_ADDRESS", address(minter));
    }
}
