// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// this code just reads code
// don't use it
contract ExternalStorageReader {
    function readStorageAtAddress(
        address contractAddress,
        uint256 slot
    ) external view returns (bytes32) {
        bytes32 value;

        assembly {
            // Set the storage pointer to the storage of the contract at contractAddress
            let ptr := mload(0x40)
            mstore(ptr, slot)
            mstore(add(ptr, 0x20), contractAddress)

            // Perform an `extcodecopy` operation to copy the data from the other contract's storage
            extcodecopy(contractAddress, ptr, 0, 0x40)
            value := mload(ptr)
        }
        return value;
    }
}
