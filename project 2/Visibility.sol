// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Visibility {
    function privateFunc() private pure returns (string memory) {
        return "private function called";
    }
}
