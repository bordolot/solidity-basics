// SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

// // You can create a separate file with enum definition
// // And then import it wherever you want
// enum Status {
//     Pending,
//     Shipped,
//     Accepted,
//     Rejected,
//     Canceled
// }

// // Example:
// import "./EnumDefinition.sol";

contract Enums {
    enum Status {
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }

    Status public status;

    function get() public view returns (Status) {
        return status;
    }

    function set(Status _status) public {
        status = _status;
    }

    function cancel() public {
        status = Status.Canceled;
    }

    function reset() public {
        delete status;
    }
}
