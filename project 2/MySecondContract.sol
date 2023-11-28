// SDPX-License-Identifier: MIT

pragma solidity ^0.8.13;

contract MySecondContract {
    string public some_string;
    uint public any_number;

    function addInfo(string memory _some_string, uint _any_number) public {
        some_string = _some_string;
        any_number = _any_number;
    }

    function add_number() public {
        any_number += 1;
    }

    function remove_number() public {
        any_number -= 1;
    }
}
