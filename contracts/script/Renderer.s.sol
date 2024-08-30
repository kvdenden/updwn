// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {console} from "forge-std/Script.sol";
import {ScriptBase} from "./Base.sol";

import {UPDWNRenderer} from "../src/UPDWNRenderer.sol";
import {UPDWN} from "../src/UPDWN.sol";

contract Deploy is ScriptBase {
    function _run() internal override {
        UPDWN updwn = UPDWN(vm.envAddress("UPDWN_CONTRACT_ADDRESS"));

        // constructor(address token_, string memory name_, string memory description_)

        UPDWNRenderer renderer = new UPDWNRenderer(address(updwn), "UP/DWN", "");
        console.log("Renderer deployed at ", address(renderer));
        _setEnv("RENDERER_CONTRACT_ADDRESS", address(renderer));

        updwn.setRenderer(address(renderer));
    }
}
