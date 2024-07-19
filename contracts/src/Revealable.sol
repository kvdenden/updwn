// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {RNGConsumerBase} from "./RNGConsumerBase.sol";
import {IRNG} from "./interfaces/IRNG.sol";

contract Revealable is RNGConsumerBase {
    bytes32 private _requestId;
    uint256 private _entropy;

    constructor(address rng) RNGConsumerBase(rng) {}

    function reveal() public virtual {
        require(_requestId > 0, "Already revealed");

        _requestId = RNG.requestEntropy();
    }

    function revealed() public view returns (bool) {
        return _entropy > 0;
    }

    function _seed() internal view returns (uint256) {
        require(_entropy > 0, "Not revealed");

        return _entropy;
    }

    function _fulfillEntropy(bytes32 requestId, uint256 entropy) internal virtual override {
        if (requestId == _requestId) {
            _entropy = entropy;
            _onRevealed();
        }
    }

    function _onRevealed() internal virtual {}
}
