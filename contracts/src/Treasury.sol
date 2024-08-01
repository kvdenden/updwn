// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import {Address} from "@openzeppelin/contracts/utils/Address.sol";

import {ITreasury} from "./interfaces/ITreasury.sol";

contract Treasury is ITreasury, AccessControl {
    using Address for address payable;

    bytes32 public constant PAYMENT_ROLE = keccak256("PAYMENT_ROLE");

    constructor(address admin) {
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
    }

    function pay(address to, uint256 amount) public override onlyRole(PAYMENT_ROLE) {
        payable(to).sendValue(amount);
    }

    function balance() public view override returns (uint256) {
        return address(this).balance;
    }

    receive() external payable {}
}
