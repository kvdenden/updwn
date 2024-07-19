// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Revealable} from "./Revealable.sol";

import {ITokenDescriptor} from "./interfaces/ITokenDescriptor.sol";

contract TokenDescriptor is Revealable, ITokenDescriptor {
    uint8 public immutable predictionCount; // max 255 predictions

    constructor(address rng, uint8 predictionCount_) Revealable(rng) {
        predictionCount = predictionCount_;
    }

    function predictionId(uint256 tokenId) public view virtual override returns (uint256) {
        uint256 seed = _seed();

        uint256 maxId = 1 << predictionCount;

        uint256 offset = seed % maxId;
        uint256 prime = 0x41c64e6d;
        return addmod(offset, mulmod(tokenId, prime, maxId), maxId); // (offset + tokenId * prime) % maxId
    }
}
