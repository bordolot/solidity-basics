// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VulnToReetrancy1 {
    mapping(address => uint256) public userBalancies;

    function deposit() external payable {
        userBalancies[msg.sender] += msg.value;
    }

    function withdrawAll() external payable {
        uint256 balance = userBalancies[msg.sender];
        require(balance > 0, "No funds to withdraw");

        (bool success, ) = msg.sender.call{value: balance}("");
        require(success, "Failed to send Ether");
        userBalancies[msg.sender] = 0; // this should be set before sending funds
    }
}
