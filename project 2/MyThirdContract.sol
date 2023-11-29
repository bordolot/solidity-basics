// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

contract MyThirdContract {
    // bool public yes;
    // bool public no = false;

    // uint8 new_num; // range 0 : 255 (2**8 - 1)
    // uint16 new_num_num; // range 0 : 65535 (2**16 - 1)

    // int256 public num_num_cat; // range -2**255 : 2**255-1

    // int public minInt = type(int).min;
    // int public maxInt = type(int).max;

    // bytes1 public nice_byte = "a";
    // bytes2 public also_nice_byte = "ab";

    // address public new_address;

    // function getInfo() public view returns (int256) {
    //     return num_num_cat;
    // }

    // function updateData(int256 _num_num_cat) public {
    //     num_num_cat = _num_num_cat;
    // }

    // function sumTwoNumbers(
    //     uint256 _a,
    //     uint256 _b
    // ) public pure returns (uint256) {
    //     uint256 newNumber = _a + _b;
    //     return newNumber;
    // }

    // // contract metadata:

    // address public owner;
    // address public myBlockchain;
    // uint256 public difficulty;
    // uint256 public gasLimit;
    // uint256 public number;
    // uint256 public timestamp;
    // uint256 public value;
    // uint256 public nowOn;
    // address public origin;
    // uint256 public gasPrice;
    // bytes public callData;
    // bytes4 public firstFour;

    // constructor() {
    //     owner = msg.sender;
    //     myBlockchain = block.coinbase;
    //     // difficulty = block.difficulty;
    //     gasLimit = block.gaslimit;
    //     number = block.number;
    //     timestamp = block.timestamp;
    //     // value = msg.value;
    //     // nowOn;
    //     origin = tx.origin;
    //     gasPrice = tx.gasprice;
    //     callData = msg.data;
    //     firstFour = msg.sig;
    // }

    uint256 num1;
    uint256 num2;

    function getResults() public view returns (uint product, uint total) {
        product = num1 * num2;
        total = num1 + num2;
    }
}
