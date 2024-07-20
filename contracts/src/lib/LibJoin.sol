// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

library LibJoin {
    function join(string[] memory values, string memory separator) internal pure returns (string memory) {
        if (values.length == 0) {
            return "";
        }
        string memory result = values[0];
        for (uint256 i = 1; i < values.length; ++i) {
            result = string.concat(result, separator, values[i]);
        }
        return result;
    }
}
