// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {IRNG} from "../../src/interfaces/IRNG.sol";
import {IRNGConsumer} from "../../src/interfaces/IRNGConsumer.sol";

contract MockRNG is IRNG {
    struct Request {
        bytes32 requestId;
        address consumer;
    }

    uint256 public immutable ENTROPY;
    Request public request; // last request

    uint256 private _nonce;

    constructor(uint256 _entropy) {
        ENTROPY = _entropy;
    }

    function requestEntropy() external returns (bytes32 requestId) {
        requestId = keccak256(abi.encodePacked(block.number, _nonce++));
        request = Request(requestId, msg.sender);
    }

    function fulfillEntropy() external {
        IRNGConsumer(request.consumer).fulfillEntropy(request.requestId, ENTROPY);
    }

    function getEntropy(bytes32 /* requestId */ ) external view returns (uint256 entropy) {
        return ENTROPY;
    }
}
