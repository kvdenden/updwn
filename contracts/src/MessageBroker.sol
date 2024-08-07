// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import {Context} from "@openzeppelin/contracts/utils/Context.sol";
import {EnumerableSet} from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

import {IMessageBroker} from "./interfaces/IMessageBroker.sol";
import {ISubscriber} from "./interfaces/ISubscriber.sol";

contract MessageBroker is IMessageBroker, Context, AccessControl {
    using EnumerableSet for EnumerableSet.AddressSet;

    bytes32 public constant PUBLISHER_ROLE = keccak256("PUBLISHER_ROLE");

    mapping(bytes32 => EnumerableSet.AddressSet) private _subscribers;

    constructor(address admin) {
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
    }

    function publish(bytes32 event_, bytes calldata data_) public override onlyRole(PUBLISHER_ROLE) {
        EnumerableSet.AddressSet storage subscribers = _subscribers[event_];

        uint256 length = subscribers.length();
        for (uint256 i = 0; i < length; i++) {
            ISubscriber(subscribers.at(i)).notify(event_, data_);
        }

        emit Publish(_msgSender(), event_, data_);
    }

    function subscribe(bytes32 event_, address subscriber) public override onlyRole(DEFAULT_ADMIN_ROLE) {
        _subscribe(event_, subscriber);
    }

    function unsubscribe(bytes32 event_, address subscriber) public override onlyRole(DEFAULT_ADMIN_ROLE) {
        _unsubscribe(event_, subscriber);
    }

    function _subscribe(bytes32 event_, address subscriber) internal {
        if (_subscribers[event_].add(subscriber)) emit Subscribe(subscriber, event_);
    }

    function _unsubscribe(bytes32 event_, address subscriber) internal {
        if (_subscribers[event_].remove(subscriber)) emit Unsubscribe(subscriber, event_);
    }
}
