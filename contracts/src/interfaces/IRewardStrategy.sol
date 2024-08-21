// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

interface IRewardStrategy {
    function nextReward() external returns (uint256);
}
