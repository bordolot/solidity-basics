// SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract NormalContract {
    event Log(string message);

    function normalFunction() public {
        emit Log("normalFunction called from NormalContract");
    }
}

contract DeceptiveContract {
    NormalContract normalContract;

    // !!! never trust unverified contracts
    constructor(address _normalContract) {
        normalContract = NormalContract(_normalContract);
    }

    function callNormalFunction() public {
        normalContract.normalFunction();
    }
}

contract MaliciousContract {
    address private myAddress;
    event Log(string message);

    constructor() {
        myAddress = msg.sender;
    }

    function normalFunction() public {
        // here you can put your malicious code
        emit Log("normalFunction called from MaliciousContract");
    }
}
