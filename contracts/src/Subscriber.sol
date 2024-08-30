// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {ISubscriber} from "./interfaces/ISubscriber.sol";
import {IMessageBroker} from "./interfaces/IMessageBroker.sol";

contract Subscriber is ISubscriber {
    IMessageBroker private _broker;

    constructor(address broker_) {
        _broker = IMessageBroker(broker_);
    }

    function notify(bytes32 event_, bytes calldata data_) external override {
        require(msg.sender == address(_broker), "Subscriber: unauthorized");

        _onEvent(event_, data_);
    }

    function _onEvent(bytes32 event_, bytes calldata data_) internal virtual {}
}
