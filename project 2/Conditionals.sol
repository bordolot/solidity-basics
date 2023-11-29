// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Conditionals {
    uint256 public myNum = 5;
    string public myString;

    function get(uint256 _num) public returns (string memory) {
        if (_num == 5) {
            myString = "the value of nyNum is 5";
        } else if (_num == 4) {
            myString = "not 5";
        } else {
            myString = "default";
        }
        return myString;
    }

    function shortHand(uint _num) public returns (string memory) {
        return _num == 5 ? myString = "is 5" : myString = "sorry its not 5";
    }
}
