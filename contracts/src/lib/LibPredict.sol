// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

library LibPredict {
    enum PriceAction {
        PRICE_DOWN,
        PRICE_UP
    }

    function getPrediction(uint256 pid, uint8 index) public pure returns (PriceAction) {
        uint256 mask = 1 << index;
        return (pid & mask) == 0 ? PriceAction.PRICE_DOWN : PriceAction.PRICE_UP;
    }
}
