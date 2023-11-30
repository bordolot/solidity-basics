// SDPX-License-Identifier
pragma solidity ^0.8.0;

contract Event {
    event Log(address indexed sender, string message);
    event AnotherLog();

    function test() public {
        emit Log(msg.sender, "hello worlds");
        emit Log(msg.sender, "hello blockchain");
        emit AnotherLog();
    }
}
