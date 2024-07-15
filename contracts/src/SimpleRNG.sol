// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {IRNG} from "./interfaces/IRNG.sol";
import {IRNGConsumer} from "./interfaces/IRNGConsumer.sol";

contract SimpleRNG is IRNG {
    error InvalidRequest(bytes32 requestId);
    error NotReady(bytes32 requestId);
    error AlreadyFulfilled(bytes32 requestId);

    event EntropyRequested(bytes32 indexed requestId, address indexed consumer);
    event EntropyFulfilled(bytes32 indexed requestId, address indexed consumer, uint256 entropy);

    struct Request {
        bool exists;
        bool fulfilled;
        address consumer;
        uint256 blockNumber;
        uint256 entropy;
    }

    uint256 private immutable _DELAY; // wait at least this many blocks before fulfilling request

    uint256 private _nonce;
    mapping(bytes32 => Request) private _requests;

    constructor(uint256 delay) {
        _DELAY = delay;
    }

    function requestEntropy() external override returns (bytes32 requestId) {
        requestId = keccak256(abi.encodePacked(block.number, _nonce++));

        address consumer = msg.sender;

        _requests[requestId] = _newRequest(consumer);
        emit EntropyRequested(requestId, consumer);
    }

    function fulfillEntropy(bytes32 requestId) external {
        Request memory request = _requests[requestId];

        if (!request.exists) revert InvalidRequest(requestId);
        if (request.fulfilled) revert AlreadyFulfilled(requestId);
        if (block.number - request.blockNumber < _DELAY) revert NotReady(requestId);

        uint256 entropy = uint256(keccak256(abi.encodePacked(requestId, block.prevrandao)));
        _fulfillRequest(requestId, entropy);

        IRNGConsumer(request.consumer).fulfillEntropy(requestId, entropy);
        emit EntropyFulfilled(requestId, request.consumer, entropy);
    }

    function getEntropy(bytes32 requestId) external view override returns (uint256 entropy) {
        Request memory request = _requests[requestId];

        if (!request.exists) revert InvalidRequest(requestId);
        if (!request.fulfilled) revert NotReady(requestId);

        return request.entropy;
    }

    function _newRequest(address consumer) internal view returns (Request memory) {
        return Request(true, false, consumer, block.number, 0);
    }

    function _fulfillRequest(bytes32 requestId, uint256 entropy) internal {
        Request storage request = _requests[requestId];
        request.fulfilled = true;
        request.entropy = entropy;
    }
}
