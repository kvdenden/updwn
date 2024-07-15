// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

interface IRNG {
    function requestEntropy() external returns (bytes32 requestId);

    function getEntropy(bytes32 requestId) external view returns (uint256 entropy);
}
