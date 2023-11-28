// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

contract first_file {
    string public my_string;
    uint public my_number;

    constructor(string memory _my_string, uint _my_number) {
        my_number = _my_number;
        my_string = _my_string;
    }

    function do_nothing() public {}
}
