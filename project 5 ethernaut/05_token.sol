// SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

// this exercise was written in solidity ^0.6.0 which was vuln to under/overflow
// OpenZeppelin introduced SafeMath library that dealt with this vuln
// solidity ^0.8.0 would just revert this transaction

contract aMonk {
    Token tokenContract;

    constructor(address _tokenContractAddr) {
        tokenContract = Token(_tokenContractAddr);
    }

    function makeTransferTo(address _addr, uint _value) public {
        tokenContract.transfer(_addr, _value);
    }
}

contract Token {
    mapping(address => uint) balances;
    uint public totalSupply;

    constructor(uint _initialSupply) public {
        balances[msg.sender] = totalSupply = _initialSupply;
    }

    function transfer(address _to, uint _value) public returns (bool) {
        require(balances[msg.sender] - _value >= 0);
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        return true;
    }

    function balanceOf(address _owner) public view returns (uint balance) {
        return balances[_owner];
    }
}
