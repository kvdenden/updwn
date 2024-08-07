// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";

import {ITreasury} from "./interfaces/ITreasury.sol";

abstract contract TreasuryBase is ITreasury, AccessControl {
    bytes32 public constant PAYMENT_ROLE = keccak256("PAYMENT_ROLE");

    constructor(address admin) {
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
    }

    function deposit(address from, uint256 amount) public payable virtual override {
        _deposit(from, amount);

        emit Deposit(from, amount);
    }

    function pay(address to, uint256 amount) public virtual override onlyRole(PAYMENT_ROLE) {
        _pay(to, amount);

        emit Payment(to, amount);
    }

    function _deposit(address from, uint256 amount) internal virtual {}
    function _pay(address to, uint256 amount) internal virtual {}
}
