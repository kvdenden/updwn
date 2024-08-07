// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {IERC20} from "@openzeppelin/contracts/interfaces/IERC20.sol";
import {IERC4626} from "@openzeppelin/contracts/interfaces/IERC4626.sol";
import {TreasuryBase} from "./TreasuryBase.sol";

contract Treasury is TreasuryBase {
    IERC4626 public vault;

    constructor(address admin, address vault_) TreasuryBase(admin) {
        vault = IERC4626(vault_);
    }

    function token() public view override returns (address) {
        return vault.asset();
    }

    function balance() public view override returns (uint256) {
        uint256 shares = vault.balanceOf(address(this));

        return vault.convertToAssets(shares);
    }

    function _deposit(address from, uint256 amount) internal override {
        IERC20(token()).transferFrom(from, address(this), amount);
        uint256 total = IERC20(token()).balanceOf(address(this));

        vault.deposit(total, address(this));
    }

    function _pay(address to, uint256 amount) internal override {
        vault.withdraw(amount, to, address(this));
    }
}
