// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

interface ITreasury {
    event Deposit(address indexed from, uint256 amount);
    event Payment(address indexed to, uint256 amount);

    function deposit(address from, uint256 amount) external payable;
    function pay(address to, uint256 amount) external;

    function token() external view returns (address);
    function balance() external view returns (uint256);
}
