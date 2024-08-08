// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {console} from "forge-std/Script.sol";
import {ScriptBase} from "./Base.sol";

import {MessageBroker} from "../src/MessageBroker.sol";

contract Deploy is ScriptBase {
    function _run() internal override {
        MessageBroker broker = new MessageBroker(deployer);
        console.log("Message broker deployed at ", address(broker));
        _setEnv("MESSAGE_BROKER_CONTRACT_ADDRESS", address(broker));
    }
}
