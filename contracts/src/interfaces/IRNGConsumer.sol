// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

interface IRNGConsumer {
    error InvalidFulfiller();

    function fulfillEntropy(bytes32 requestId, uint256 entropy) external;
}
