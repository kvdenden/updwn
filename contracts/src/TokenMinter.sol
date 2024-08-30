// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Address} from "@openzeppelin/contracts/utils/Address.sol";

import {IMintable} from "./interfaces/IMintable.sol";
import {ITreasury} from "./interfaces/ITreasury.sol";

contract TokenMinter {
    using Address for address payable;

    uint256 private immutable _PRICE;

    IMintable private immutable _TOKEN;
    ITreasury private immutable _TREASURY;

    constructor(uint256 price_, address token_, address treasury_) {
        _PRICE = price_;
        _TOKEN = IMintable(token_);
        _TREASURY = ITreasury(treasury_);

        require(_TREASURY.token() == address(0), "Invalid treasury token");
    }

    function price() public view returns (uint256) {
        return _PRICE;
    }

    function token() public view returns (address) {
        return address(_TOKEN);
    }

    function treasury() public view returns (address) {
        return address(_TREASURY);
    }

    function mint(uint256 amount, address to) external payable returns (uint256[] memory tokenIds) {
        require(msg.value >= _PRICE * amount, "Insufficient funds");

        tokenIds = new uint256[](amount);
        for (uint256 i = 0; i < amount; i++) {
            tokenIds[i] = _TOKEN.mint(to);
        }
    }

    function withdraw() external {
        uint256 amount = address(this).balance;
        _TREASURY.deposit{value: amount}(address(this), amount);
    }
}
