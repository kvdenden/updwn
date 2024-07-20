// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {LibPredict} from "../lib/LibPredict.sol";

interface ITokenDescriptor {
    function predictionCount() external view returns (uint8);
    function predictionId(uint256 tokenId) external view returns (uint256);
}
