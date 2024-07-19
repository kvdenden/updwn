// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Context} from "@openzeppelin/contracts/utils/Context.sol";

import {IRNGConsumer} from "./interfaces/IRNGConsumer.sol";
import {IRNG} from "./interfaces/IRNG.sol";

abstract contract RNGConsumerBase is IRNGConsumer, Context {
    IRNG immutable RNG;

    constructor(address rng) {
        RNG = IRNG(rng);
    }

    function fulfillEntropy(bytes32 requestId, uint256 entropy) external override {
        if (_msgSender() != address(RNG)) revert InvalidFulfiller();

        _fulfillEntropy(requestId, entropy);
    }

    function _fulfillEntropy(bytes32 requestId, uint256 entropy) internal virtual;
}
