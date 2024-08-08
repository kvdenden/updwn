// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {console} from "forge-std/Script.sol";
import {ScriptBase} from "./Base.sol";

import {GameEngine} from "../src/GameEngine.sol";
import {MessageBroker} from "../src/MessageBroker.sol";

contract Deploy is ScriptBase {
    function _run() internal override {
        address updwn = vm.envAddress("UPDWN_CONTRACT_ADDRESS");
        address priceFeed = vm.envAddress("PRICE_FEED_CONTRACT_ADDRESS");
        address treasury = vm.envAddress("TREASURY_CONTRACT_ADDRESS");

        MessageBroker broker = MessageBroker(vm.envAddress("MESSAGE_BROKER_CONTRACT_ADDRESS"));

        GameEngine game = new GameEngine(updwn, priceFeed, treasury, address(broker));
        console.log("Game engine deployed at ", address(game));
        _setEnv("GAME_ENGINE_CONTRACT_ADDRESS", address(game));

        broker.subscribe(keccak256("pricefeed.update"), address(game));
    }
}
