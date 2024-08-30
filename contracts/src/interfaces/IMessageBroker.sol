// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

interface IMessageBroker {
    event Publish(address indexed publisher, bytes32 indexed event_, bytes data);

    event Subscribe(address indexed subscriber, bytes32 indexed event_);
    event Unsubscribe(address indexed subscriber, bytes32 indexed event_);

    function publish(bytes32 event_, bytes calldata data_) external;
    function subscribe(bytes32 event_, address subscriber_) external;
    function unsubscribe(bytes32 event_, address subscriber_) external;
}
