// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {IMessageBroker} from "./interfaces/IMessageBroker.sol";

contract Publisher {
    IMessageBroker private _broker;

    constructor(address broker_) {
        _broker = IMessageBroker(broker_);
    }

    function _publish(bytes32 event_, bytes memory data_) internal {
        _broker.publish(event_, data_);
    }
}
