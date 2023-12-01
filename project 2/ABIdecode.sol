// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AbiDecode {
    struct MyStruct {
        string name;
        uint[2] nums;
    }

    function encode(
        uint _x,
        address _addr,
        uint[] calldata _arr,
        MyStruct calldata _myStruct
    ) external pure returns (bytes memory) {
        return abi.encode(_x, _addr, _arr, _myStruct);
    }

    function decode(
        bytes calldata _data
    )
        external
        pure
        returns (
            uint x,
            address addr,
            uint[] memory arr,
            MyStruct memory myStruct
        )
    {
        (x, addr, arr, myStruct) = abi.decode(
            _data,
            (uint, address, uint[], MyStruct)
        );
    }
}
