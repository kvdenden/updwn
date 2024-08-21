// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Script} from "forge-std/Script.sol";
import {ScriptBase} from "./Base.sol";

import {Deploy as DeployRNG} from "./RNG.s.sol";
import {Deploy as DeployMessageBroker} from "./MessageBroker.s.sol";
import {Deploy as DeployPriceFeed} from "./PriceFeed.s.sol";
import {Deploy as DeployUPDWN} from "./UPDWN.s.sol";
import {Deploy as DeployRenderer} from "./Renderer.s.sol";
import {Deploy as DeployTreasury} from "./Treasury.s.sol";
import {Deploy as DeployRewardStrategy} from "./RewardStrategy.s.sol";
import {Deploy as DeployGameEngine} from "./GameEngine.s.sol";
import {Deploy as DeployTokenMinter} from "./TokenMinter.s.sol";

contract DeployAll is Script {
    ScriptBase[] scripts;

    function setUp() public {
        scripts.push(new DeployRNG());
        scripts.push(new DeployMessageBroker());
        scripts.push(new DeployPriceFeed());
        scripts.push(new DeployUPDWN());
        scripts.push(new DeployRenderer());
        scripts.push(new DeployTreasury());
        scripts.push(new DeployRewardStrategy());
        scripts.push(new DeployGameEngine());
        scripts.push(new DeployTokenMinter());

        for (uint256 i; i < scripts.length; i++) {
            scripts[i].setUp();
        }
    }

    function run() public {
        for (uint256 i; i < scripts.length; i++) {
            scripts[i].run();
        }
    }
}
