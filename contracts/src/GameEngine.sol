// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Subscriber} from "./Subscriber.sol";
import {UPDWN} from "./UPDWN.sol";
import {IPriceFeed} from "./interfaces/IPriceFeed.sol";
import {ITreasury} from "./interfaces/ITreasury.sol";

import {LibPredict} from "./lib/LibPredict.sol";

contract GameEngine is Subscriber {
    using LibPredict for UPDWN;
    using LibPredict for IPriceFeed;

    event ClaimReward(uint256 indexed epoch, address indexed winner, uint256 amount);

    UPDWN public immutable updwn;
    IPriceFeed public immutable priceFeed;
    ITreasury public immutable treasury;

    uint256 public epoch;

    struct Reward {
        uint256 amount;
        bool claimed;
    }

    mapping(uint256 => Reward) private _rewards;

    constructor(address updwn_, address priceFeed_, address treasury_, address broker_) Subscriber(broker_) {
        updwn = UPDWN(updwn_);
        priceFeed = IPriceFeed(priceFeed_);
        treasury = ITreasury(treasury_);
    }

    function getReward(uint256 epoch_) public view returns (Reward memory) {
        return _rewards[epoch_];
    }

    function matches(uint256 tokenId) public view returns (uint256) {
        LibPredict.PriceAction[] memory predictions = updwn.getPredictions(tokenId);
        return priceFeed.matches(predictions);
    }

    function claimReward(uint256 tokenId) public {
        require(matches(tokenId) == updwn.predictionCount(), "No match");

        Reward storage reward = _rewards[epoch];

        require(!reward.claimed, "Already claimed");

        uint256 amount = reward.amount;
        address winner = updwn.ownerOf(tokenId);
        treasury.pay(winner, amount);

        reward.claimed = true;

        emit ClaimReward(epoch, winner, amount);
    }

    function _calculateRewardAmount() internal view virtual returns (uint256) {
        return treasury.balance() / 100;
    }

    function _onEvent(bytes32 event_, bytes calldata /* data_ */ ) internal virtual override {
        if (event_ == keccak256("pricefeed.update")) {
            // (uint256 index, int256 answer) = abi.decode(data_, (uint256, int256));

            uint256 amount = _calculateRewardAmount();
            _rewards[++epoch] = Reward(amount, false);
        }
    }
}
