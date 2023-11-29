// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

contract Loops {
    uint256[] data;
    uint8 k = 0;

    function whileLoop() public returns (uint256[] memory) {
        while (k < 5) {
            k++;
            data.push(k);
        }
        return data;
    }

    function doWhileLoop() public returns (uint256[] memory) {
        do {
            k++;
            data.push(k);
        } while (k < 5);
        return data;
    }

    function forLoop() public returns (uint256[] memory) {
        for (uint256 i = 0; i < 5; i++) {
            data.push(i);
        }
        return data;
    }
}
