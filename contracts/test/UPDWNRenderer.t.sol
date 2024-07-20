// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Test, console2} from "forge-std/Test.sol";

import {MockRNG} from "./mocks/MockRNG.sol";
import {UPDWN} from "../src/UPDWN.sol";
import {UPDWNRenderer} from "../src/UPDWNRenderer.sol";

contract UPDWNRendererTest is Test {
    MockRNG rng;
    UPDWN updwn;
    UPDWNRenderer renderer;

    function setUp() public {
        rng = new MockRNG(42);
        updwn = new UPDWN(address(this), address(rng), 12);
        renderer = new UPDWNRenderer(address(updwn), "UP/DWN", "Will eth go up or down?");

        updwn.setRenderer(address(renderer));

        updwn.grantRole(updwn.MINTER_ROLE(), address(this));
    }

    function testUnrevealed() public {
        uint256 tokenId = updwn.mint(address(this));

        string memory uri = renderer.tokenURI(tokenId);
        console2.log("URI: ", uri);
    }

    function testRevealed() public {
        uint256 tokenId = updwn.mint(address(this));

        _reveal();

        console2.log("Prediction id: ", updwn.predictionId(tokenId));

        string memory uri = renderer.tokenURI(tokenId);
        console2.log("URI: ", uri);
    }

    function _reveal() internal {
        updwn.reveal();
        rng.fulfillEntropy();
    }
}
