// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {ITokenDescriptor} from "../interfaces/ITokenDescriptor.sol";

library LibPredict {
    enum PriceAction {
        PRICE_DOWN,
        PRICE_UP
    }

    function getPredictions(ITokenDescriptor descriptor, uint256 tokenId)
        internal
        view
        returns (PriceAction[] memory)
    {
        uint8 count = descriptor.predictionCount();
        PriceAction[] memory predictions = new PriceAction[](count);

        uint256 pid = descriptor.predictionId(tokenId);
        for (uint8 i; i < count; i++) {
            predictions[i] = _getPrediction(pid, i);
        }

        return predictions;
    }

    function _getPrediction(uint256 pid, uint8 index) private pure returns (PriceAction) {
        uint256 mask = 1 << index;
        return (pid & mask) == 0 ? PriceAction.PRICE_DOWN : PriceAction.PRICE_UP;
    }
}
