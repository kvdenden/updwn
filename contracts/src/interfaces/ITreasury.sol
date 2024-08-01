// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

interface ITreasury {
    function pay(address to, uint256 amount) external;
    function balance() external view returns (uint256);
}
