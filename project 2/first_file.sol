// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

/**
all reference variable types:
    > arrays
    > mappings
    > strings
    > bytes
    > structs

all value variable types:
    > Integers : int and uint
    > Booleans: bool
    > Addresses: address
    > Enums: enum
    > Fixed point numbers: fixed, ufixed

composite data type"
    > tuple


 */

contract first_file {
    string public my_string;
    uint public my_number;

    constructor(string memory _my_string, uint _my_number) {
        my_number = _my_number;
        my_string = _my_string;
    }

    function do_nothing(uint256 _num, address _addr) public {}
}
