// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {console} from "forge-std/Script.sol";
import {ScriptBase} from "./Base.sol";

import {GameEngine} from "../src/GameEngine.sol";
import {TreasuryBase} from "../src/TreasuryBase.sol";
import {RewardStrategyBase} from "../src/RewardStrategyBase.sol";
import {MessageBroker} from "../src/MessageBroker.sol";

contract Deploy is ScriptBase {
    function _run() internal override {
        address updwn = vm.envAddress("UPDWN_CONTRACT_ADDRESS");
        address priceFeed = vm.envAddress("PRICE_FEED_CONTRACT_ADDRESS");

        TreasuryBase treasury = TreasuryBase(vm.envAddress("TREASURY_CONTRACT_ADDRESS"));
        RewardStrategyBase strategy = RewardStrategyBase(vm.envAddress("REWARD_STRATEGY_CONTRACT_ADDRESS"));
        MessageBroker broker = MessageBroker(vm.envAddress("MESSAGE_BROKER_CONTRACT_ADDRESS"));

        GameEngine game = new GameEngine(updwn, priceFeed, address(treasury), address(strategy), address(broker));
        console.log("Game engine deployed at ", address(game));
        _setEnv("GAME_ENGINE_CONTRACT_ADDRESS", address(game));

        treasury.grantRole(treasury.PAYMENT_ROLE(), address(game));
        strategy.grantRole(strategy.REWARD_ROLE(), address(game));

        broker.subscribe(keccak256("pricefeed.update"), address(game));
    }
}
