// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SolveSolverCall {
    function whatIsTheMeaningOfLife() public pure returns (uint8) {
        return 42;
    }
}

contract SolveSolver {
    event Log(address addr);

    // Deploys a contract that always returns 42
    function deploy() external {
        bytes memory bytecode = hex"69602a60005260206000f3600052600a6016f3";
        address addr;
        assembly {
            // create(value, offset, size)
            addr := create(0, add(bytecode, 0x20), 0x13)
        }
        require(addr != address(0));

        emit Log(addr);
    }
}
//0xaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
//0x0000000000000000000000000000000000000000000000000000000000000001
//"dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd"