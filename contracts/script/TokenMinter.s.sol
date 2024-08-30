// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {console} from "forge-std/Script.sol";
import {ScriptBase} from "./Base.sol";

import {TokenMinter} from "../src/TokenMinter.sol";
import {UPDWN} from "../src/UPDWN.sol";

contract Deploy is ScriptBase {
    function _run() internal override {
        uint256 price = vm.envUint("TOKEN_PRICE");
        address treasury = vm.envAddress("TREASURY_CONTRACT_ADDRESS");

        UPDWN updwn = UPDWN(vm.envAddress("UPDWN_CONTRACT_ADDRESS"));

        TokenMinter minter = new TokenMinter(price, address(updwn), treasury);
        console.log("Token minter deployed at ", address(minter));
        _setEnv("TOKEN_MINTER_CONTRACT_ADDRESS", address(minter));

        updwn.grantRole(updwn.MINTER_ROLE(), address(minter));
    }
}
