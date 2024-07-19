// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
// import {IERC4906} from "@openzeppelin/contracts/interfaces/IERC4906.sol";

import {SimpleERC721} from "./SimpleERC721.sol";
import {TokenDescriptor} from "./TokenDescriptor.sol";
import {ITokenRenderer} from "./interfaces/ITokenRenderer.sol";

contract UPDWN is SimpleERC721, TokenDescriptor, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    ITokenRenderer public renderer;

    constructor(address admin, address rng, uint8 size)
        SimpleERC721(2 ** size, "UP/DWN", "UP/DWN")
        TokenDescriptor(rng, size)
    {
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
    }

    function mint(address to) public override onlyRole(MINTER_ROLE) returns (uint256 tokenId) {
        return super.mint(to);
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireOwned(tokenId);

        return renderer.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(SimpleERC721, AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function setRenderer(address renderer_) public onlyRole(DEFAULT_ADMIN_ROLE) {
        renderer = ITokenRenderer(renderer_);
    }

    function _onRevealed() internal virtual override {
        _refreshMetadata();
    }
}
