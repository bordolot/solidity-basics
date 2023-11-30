// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

contract Modifiers {
    address public owner;
    uint256 public x = 10;
    bool public locked;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }

    modifier validateData(address _addr) {
        require(_addr != address(0), "not valid data");
        _;
    }

    function changeOwner(
        address _newOwner
    ) public onlyOwner validateData(_newOwner) {
        owner = _newOwner;
    }

    modifier noReentrancy(){
        require(!locked, "No reentrancy");
        locked = true;
        _;
        locked = false;
    }

    function decrement(uint256 i) public noReentrancy(){
        x -= 1;
        if(i > 1){
            decrement(i -1);
        }
    }



}
