// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

interface IMintable {
    function mint(address to) external returns (uint256 tokenId);
}
