// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Address} from "@openzeppelin/contracts/utils/Address.sol";

import {TreasuryBase} from "./TreasuryBase.sol";

contract SimpleETHTreasury is TreasuryBase {
    using Address for address payable;

    constructor(address admin) TreasuryBase(admin) {}

    function token() public pure override returns (address) {
        return address(0);
    }

    function balance() public view override returns (uint256) {
        return address(this).balance;
    }

    function _deposit(address, uint256 amount) internal override {
        require(msg.value == amount, "Invalid deposit amount");
    }

    function _pay(address to, uint256 amount) internal override {
        payable(to).sendValue(amount);
    }

    receive() external payable {}
}
