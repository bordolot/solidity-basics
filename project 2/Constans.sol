// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Constans {
    // execution cost	70063 gas
    // transaction cost	128297 gas
    address public myAddress = address(12);

    // execution cost	41891 gas
    // transaction cost	98651 gas
    address public constant myConstantAddress = address(13);
}
