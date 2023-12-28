// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyContract {
    function foo(uint _num1, uint _num2) public {}

    function fooStart(
        IFoo target
    )
        external
        pure
        returns (bytes32, bytes32, bytes32, bytes32, bytes32, bytes32)
    {
        bytes[] memory data = new bytes[](3);
        // data[0] = abi.encode(0x12);
        data[0] = abi.encodeWithSelector(this.foo.selector, 100, 10);
        data[1] = abi.encode(0x34);
        data[2] = abi.encode(0x56);
        (
            bytes32 data_1,
            bytes32 data_2,
            bytes32 data_3,
            bytes32 data_4,
            bytes32 data_5,
            bytes32 data_6
        ) = target.foo(data);

        return (data_1, data_2, data_3, data_4, data_5, data_6);
    }

    //0x00
    //0x0000000000000000000000000000000000000000000000000000000000000000
    //0x20
    //0x0000000000000000000000000000000000000000000000000000000000000000
    //0x40
    //0x00000000000000000000000000000000000000000000000000000000000001c0
    //0x60
    //0x0000000000000000000000000000000000000000000000000000000000000000

    //0x80
    //0x0000000000000000000000000000000000000000000000000000000000000003
    //0x0a0
    //0x0000000000000000000000000000000000000000000000000000000000000100
    //0x0c0
    //0x0000000000000000000000000000000000000000000000000000000000000140
    //0x0e0
    //0x0000000000000000000000000000000000000000000000000000000000000180
    //0x100
    //0x0000000000000000000000000000000000000000000000000000000000000001
    //0x120
    //0x1200000000000000000000000000000000000000000000000000000000000000

    //0x140
    //0x0000000000000000000000000000000000000000000000000000000000000001
    //0x160
    //0x3400000000000000000000000000000000000000000000000000000000000000
    //0x180
    //0x0000000000000000000000000000000000000000000000000000000000000001
    //0x1a0
    //0x5600000000000000000000000000000000000000000000000000000000000000
    //0x1c0
    //0x0000000000000000000000000000000000000000000000000000000000000000
    //0x1e0
    //0x0000000000000000000000000000000000000000000000000000000000000000
}

interface IFoo {
    function foo(
        bytes[] calldata data
    )
        external
        pure
        returns (bytes32, bytes32, bytes32, bytes32, bytes32, bytes32);
}

contract Foo {
    function foo(
        bytes[] calldata data
    )
        public
        pure
        returns (bytes32, bytes32, bytes32, bytes32, bytes32, bytes32)
    {
        bytes memory _data_1 = data[0];
        bytes memory _data_2 = data[1];
        bytes memory _data_3 = data[2];
        // data[0] = hex"12";
        // data[1] = hex"34";
        // data[2] = hex"56";

        // data[0] = "0x12";
        // data[1] = "0x34";
        // data[2] = "0x56";

        // data[0] = abi.encode(0x12);

        bytes32 test_1;
        bytes32 test_2;
        bytes32 test_3;
        bytes32 test_4;
        bytes32 test_5;
        bytes32 test_6;

        assembly {
            test_1 := mload(0x00)
            test_2 := mload(0x020)
            test_3 := mload(0x040)
            test_4 := mload(0x060)
            test_5 := mload(0x080)
            test_6 := mload(0x0a0)

            // test_1 := mload(0x080)
            // test_2 := mload(0x0a0)
            // test_3 := mload(0x0c0)
            // test_4 := mload(0x0e0)
            // test_5 := mload(0x100)
            // test_6 := mload(0x120)

            // test_1 := mload(0x140)
            // test_2 := mload(0x160)
            // test_3 := mload(0x180)
            // test_4 := mload(0x1a0)
            // test_5 := mload(0x1c0)
            // test_6 := mload(0x1e0)
        }
        return (test_1, test_2, test_3, test_4, test_5, test_6);
    }
}
