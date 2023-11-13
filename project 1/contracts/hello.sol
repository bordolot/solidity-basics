// SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;

contract Hello {

    uint storedData;

    function set(uint x) public {
        storedData = x;
    }

    function get() public view returns(uint){
        return storedData;
    }

    // string public welcome = "Hello Worlds";

    // function set(string someString) public {
    //     welcome = someString;
    // }

}