// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {console} from "forge-std/Script.sol";
import {ScriptBase} from "./Base.sol";

import {SimpleRNG} from "../src/SimpleRNG.sol";

contract Deploy is ScriptBase {
    function _run() internal override {
        SimpleRNG rng = new SimpleRNG(8);
        console.log("SimpleRNG deployed at ", address(rng));
        _setEnv("RNG_CONTRACT_ADDRESS", address(rng));
    }
}
