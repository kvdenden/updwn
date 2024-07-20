// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {IMintable} from "./interfaces/IMintable.sol";

contract TokenMinter {
    IMintable private _token;

    uint256 public constant TOKEN_PRICE = 0.08 ether;

    constructor(address token) {
        _token = IMintable(token);
    }

    function mint(uint256 amount, address to) external payable returns (uint256[] memory tokenIds) {
        require(msg.value >= TOKEN_PRICE * amount, "Insufficient funds");

        tokenIds = new uint256[](amount);
        for (uint256 i = 0; i < amount; i++) {
            tokenIds[i] = _token.mint(to);
        }

        // TODO: send mint fee to treasury/vault
    }
}
