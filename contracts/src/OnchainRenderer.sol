// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Metadata, DisplayType} from "shipyard-core/onchain/Metadata.sol";
import {json} from "shipyard-core/onchain/json.sol";
import {Solarray} from "solarray/Solarray.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

import {ITokenRenderer} from "./interfaces/ITokenRenderer.sol";

abstract contract OnchainRenderer is ITokenRenderer {
    using Strings for uint256;

    address private _token;

    string private _name;
    string private _description;

    constructor(address token_, string memory name_, string memory description_) {
        _token = token_;
        _name = name_;
        _description = description_;
    }

    function token() public view virtual returns (address) {
        return _token;
    }

    function tokenURI(uint256 tokenId) public view virtual returns (string memory) {
        return Metadata.base64JsonDataURI(metadata(tokenId));
    }

    function metadata(uint256 tokenId) public view virtual returns (string memory) {
        return json.objectOf(
            Solarray.strings(
                json.property("name", _getName(tokenId)),
                json.property("description", _getDescription(tokenId)),
                json.property("image", Metadata.base64SvgDataURI(_getImage(tokenId))),
                json.rawProperty("attributes", json.arrayOf(_getAttributes(tokenId)))
            )
        );
    }

    function _getName(uint256 tokenId) internal view virtual returns (string memory) {
        return string.concat(_name, " #", tokenId.toString());
    }

    function _getDescription(uint256 /* tokenId */ ) internal view virtual returns (string memory) {
        return _description;
    }

    function _getImage(uint256 tokenId) internal view virtual returns (string memory);

    function _getAttributes(uint256 /* tokenId */ ) internal view virtual returns (string[] memory);
}
