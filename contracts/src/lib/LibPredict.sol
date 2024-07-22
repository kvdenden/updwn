// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

import {IPriceFeed} from "../interfaces/IPriceFeed.sol";
import {ITokenDescriptor} from "../interfaces/ITokenDescriptor.sol";

library LibPredict {
    enum PriceAction {
        PRICE_DOWN,
        PRICE_UP
    }

    function getPriceAction(IPriceFeed feed, uint256 index1, uint256 index2) internal view returns (PriceAction) {
        int256 price1 = feed.getPrice(index1);
        int256 price2 = feed.getPrice(index2);

        return price2 > price1 ? PriceAction.PRICE_UP : PriceAction.PRICE_DOWN;
    }

    function getRecentPriceAction(IPriceFeed feed, uint256 maxCount) internal view returns (PriceAction[] memory) {
        uint256 priceCount = feed.priceCount();

        if (priceCount < 2) {
            return new PriceAction[](0);
        }

        uint256 count = Math.min(maxCount, priceCount - 1);
        PriceAction[] memory priceAction = new PriceAction[](count);

        uint256 offset = priceCount - count - 1;
        for (uint256 i; i < count; i++) {
            priceAction[i] = getPriceAction(feed, offset + i, offset + i + 1);
        }

        return priceAction;
    }

    function matches(IPriceFeed feed, PriceAction[] memory predictions) internal view returns (uint256) {
        PriceAction[] memory priceAction = getRecentPriceAction(feed, predictions.length);

        for (uint256 len = priceAction.length; len > 0; len--) {
            bool mismatch;
            for (uint256 i; i < len; i++) {
                if (predictions[i] != priceAction[priceAction.length - len + i]) {
                    mismatch = true;
                    break;
                }
            }

            if (!mismatch) return len;
        }

        return 0;
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
