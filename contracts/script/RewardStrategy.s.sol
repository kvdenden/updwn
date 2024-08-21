// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {console} from "forge-std/Script.sol";
import {ScriptBase} from "./Base.sol";

import {FixedRateRewardStrategy} from "../src/FixedRateRewardStrategy.sol";

contract Deploy is ScriptBase {
    function _run() internal override {
        address treasury = vm.envAddress("TREASURY_CONTRACT_ADDRESS");
        uint256 rate = vm.envUint("REWARD_RATE");

        FixedRateRewardStrategy strategy = new FixedRateRewardStrategy(deployer, treasury, rate);

        console.log("Reward strategy deployed at ", address(strategy));
        _setEnv("REWARD_STRATEGY_CONTRACT_ADDRESS", address(strategy));
    }
}
