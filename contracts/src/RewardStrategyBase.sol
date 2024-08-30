// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";

import {IRewardStrategy} from "./interfaces/IRewardStrategy.sol";
import {ITreasury} from "./interfaces/ITreasury.sol";

abstract contract RewardStrategyBase is IRewardStrategy, AccessControl {
    bytes32 public constant REWARD_ROLE = keccak256("REWARD_ROLE");

    address public immutable treasury;

    constructor(address admin, address treasury_) {
        _grantRole(DEFAULT_ADMIN_ROLE, admin);

        treasury = treasury_;
    }

    function nextReward() public onlyRole(REWARD_ROLE) returns (uint256) {
        uint256 balance = ITreasury(treasury).balance();
        return _nextReward(balance);
    }

    function _nextReward(uint256 balance) internal virtual returns (uint256);
}
