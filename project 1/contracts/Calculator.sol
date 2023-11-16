// SPDX-License-Identifier: MIT

// contract hash: 0x1704555D624DBc6130fa6328Cfa318d2dD121865

pragma solidity ^0.8.0;

contract Calculator{
    uint result = 0;

    function add(uint256 num) public {
        result += num;
    }

    function subtract(uint256 num) public {
        result -= num;
    }

    function multiply(uint256 num) public {
        result *= num;
    }

    function get() public view returns (uint256){
        return result;
    }


}