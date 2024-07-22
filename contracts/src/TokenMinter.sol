// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Address} from "@openzeppelin/contracts/utils/Address.sol";

import {IMintable} from "./interfaces/IMintable.sol";

contract TokenMinter {
    using Address for address payable;

    IMintable private _token;
    address payable private _treasury;

    uint256 public constant TOKEN_PRICE = 0.08 ether;

    constructor(address token_, address treasury_) {
        _token = IMintable(token_);
        _treasury = payable(treasury_);
    }

    function token() public view returns (address) {
        return address(_token);
    }

    function treasury() public view returns (address) {
        return _treasury;
    }

    function mint(uint256 amount, address to) external payable returns (uint256[] memory tokenIds) {
        require(msg.value >= TOKEN_PRICE * amount, "Insufficient funds");

        tokenIds = new uint256[](amount);
        for (uint256 i = 0; i < amount; i++) {
            tokenIds[i] = _token.mint(to);
        }
    }

    function withdraw() external {
        _treasury.sendValue(address(this).balance);
    }
}
