// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {IERC165} from "@openzeppelin/contracts/interfaces/IERC165.sol";
import {IERC4906} from "@openzeppelin/contracts/interfaces/IERC4906.sol";

contract SimpleERC721 is ERC721, IERC4906 {
    error SoldOut();

    uint256 public immutable MAX_SUPPLY;

    uint256 private _mintCounter;

    constructor(uint256 maxSupply, string memory name_, string memory symbol_) ERC721(name_, symbol_) {
        MAX_SUPPLY = maxSupply;
    }

    function soldOut() public view virtual returns (bool) {
        return _mintCounter >= MAX_SUPPLY;
    }

    function totalSupply() public view virtual returns (uint256) {
        return _mintCounter;
    }

    function mint(address to) public virtual returns (uint256 tokenId) {
        if (_mintCounter >= MAX_SUPPLY) revert SoldOut();

        tokenId = _mintCounter++;
        _mint(to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, IERC165) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function _refreshMetadata() internal {
        emit BatchMetadataUpdate(0, type(uint256).max);
    }
}
