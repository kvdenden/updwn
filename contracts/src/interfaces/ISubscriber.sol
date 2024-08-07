// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

interface ISubscriber {
    function notify(bytes32 event_, bytes calldata data_) external;
}
