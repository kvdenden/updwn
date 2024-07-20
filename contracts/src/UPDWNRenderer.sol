// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Metadata} from "shipyard-core/onchain/Metadata.sol";
import {svg} from "shipyard-core/onchain/svg.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

import {OnchainRenderer} from "./OnchainRenderer.sol";

import {LibJoin} from "./lib/LibJoin.sol";
import {LibPredict} from "./lib/LibPredict.sol";
import {UPDWN} from "./UPDWN.sol";

contract UPDWNRenderer is OnchainRenderer {
    using LibPredict for UPDWN;
    using LibJoin for string[];
    using Strings for uint256;

    constructor(address token_, string memory name_, string memory description_)
        OnchainRenderer(token_, name_, description_)
    {}

    function _getImage(uint256 tokenId) internal view override returns (string memory) {
        LibPredict.PriceAction[] memory predictions = _getPredictions(tokenId);

        uint256 imageSize = _imageSize();

        return svg.top({
            props: string.concat(svg.prop("width", imageSize.toString()), svg.prop("height", imageSize.toString())),
            children: string.concat(_defs(), _columns(predictions))
        });
    }

    function _imageSize() internal view virtual returns (uint256) {
        UPDWN updwn = UPDWN(token());

        return updwn.predictionCount() * _cellSize();
    }

    function _cellSize() internal view virtual returns (uint256) {
        return 24;
    }

    function _defs() internal view virtual returns (string memory) {
        string memory up = svg.el({
            tag: "path",
            props: string.concat(
                svg.prop("id", "up"), svg.prop("d", "m18 15-6-6-6 6"), svg.prop("fill", "none"), svg.prop("stroke", "green")
                )
        });

        string memory dwn = svg.el({
            tag: "path",
            props: string.concat(
                svg.prop("id", "dwn"), svg.prop("d", "m6 9 6 6 6-6"), svg.prop("fill", "none"), svg.prop("stroke", "red")
                )
        });

        return svg.el({tag: "defs", props: "", children: string.concat(up, dwn)});
    }

    function _columns(LibPredict.PriceAction[] memory predictions) internal view virtual returns (string memory) {
        string[] memory columns = new string[](predictions.length);
        for (uint8 i; i < predictions.length; i++) {
            columns[i] = _column(i, predictions[i]);
        }

        return svg.el({tag: "g", props: "", children: columns.join("")});
    }

    function _column(uint8 index, LibPredict.PriceAction prediction) internal view virtual returns (string memory) {
        uint256 x = index * _cellSize();
        uint256 y = _imageSize() / 2 - _cellSize();

        return svg.el({
            tag: "use",
            props: string.concat(
                svg.prop("href", string.concat("#", prediction == LibPredict.PriceAction.PRICE_UP ? "up" : "dwn")),
                svg.prop("x", x.toString()),
                svg.prop("y", y.toString())
                )
        });
    }

    function _getAttributes(uint256 tokenId) internal view override returns (string[] memory) {
        LibPredict.PriceAction[] memory predictions = _getPredictions(tokenId);

        string[] memory attributes = new string[](predictions.length);
        for (uint256 i; i < predictions.length; i++) {
            string memory name = string.concat("Prediction ", (i + 1).toString());
            string memory value = predictions[i] == LibPredict.PriceAction.PRICE_UP ? "UP" : "DWN";
            attributes[i] = Metadata.attribute(name, value);
        }

        return attributes;
    }

    function _getPredictions(uint256 tokenId) internal view returns (LibPredict.PriceAction[] memory) {
        UPDWN updwn = UPDWN(token());

        if (updwn.revealed()) {
            return updwn.getPredictions(tokenId);
        } else {
            return new LibPredict.PriceAction[](0);
        }
    }
}
