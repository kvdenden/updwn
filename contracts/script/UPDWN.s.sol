// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {console} from "forge-std/Script.sol";
import {ScriptBase} from "./Base.sol";

import {UPDWN} from "../src/UPDWN.sol";

contract Deploy is ScriptBase {
    function _run() internal override {
        address rng = vm.envAddress("RNG_CONTRACT_ADDRESS");

        UPDWN updwn = new UPDWN(deployer, rng, 12);
        console.log("UPDWN deployed at ", address(updwn));
        _setEnv("UPDWN_CONTRACT_ADDRESS", address(updwn));
    }
}
