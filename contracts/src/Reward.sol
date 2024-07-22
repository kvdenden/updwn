// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {UPDWN} from "./UPDWN.sol";
import {IPriceFeed} from "./interfaces/IPriceFeed.sol";

import {LibPredict} from "./lib/LibPredict.sol";

contract Reward {
    using LibPredict for UPDWN;
    using LibPredict for IPriceFeed;

    UPDWN private _updwn;
    IPriceFeed private _priceFeed;

    constructor(address updwn_, address priceFeed_) {
        _updwn = UPDWN(updwn_);
        _priceFeed = IPriceFeed(priceFeed_);
    }

    function isFullMatch(uint256 tokenId) public view returns (bool) {
        return matches(tokenId) == _updwn.predictionCount();
    }

    function matches(uint256 tokenId) public view returns (uint256) {
        LibPredict.PriceAction[] memory predictions = _updwn.getPredictions(tokenId);
        return _priceFeed.matches(predictions);
    }
}
