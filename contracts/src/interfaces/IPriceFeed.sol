// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

interface IPriceFeed {
    event PriceUpdated(uint256 indexed index, int256 price);

    function priceCount() external view returns (uint256);

    function getCurrentPrice() external view returns (int256);
    function getPrice(uint256 index) external view returns (int256);
}
