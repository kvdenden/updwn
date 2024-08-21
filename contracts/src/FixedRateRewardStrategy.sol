// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {RewardStrategyBase} from "./RewardStrategyBase.sol";
import {ITreasury} from "./interfaces/ITreasury.sol";

contract FixedRateRewardStrategy is RewardStrategyBase {
    uint256 public constant RATE_DIVISOR = 1000000;
    uint256 public immutable REWARD_RATE;

    constructor(address admin, address treasury_, uint256 rate_) RewardStrategyBase(admin, treasury_) {
        REWARD_RATE = rate_;
    }

    function _nextReward(uint256 balance) internal virtual override returns (uint256) {
        return balance * REWARD_RATE / RATE_DIVISOR;
    }
}
