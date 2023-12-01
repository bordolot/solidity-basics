// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Foo {
    address public owner;

    constructor(address _owner) {
        require(_owner != address(0), "inwalid address");
        assert(_owner != 0x0000000000000000000000000000000000000001);
        owner = _owner;
    }

    function myFunc(uint _x) public pure returns (string memory) {
        require(_x != 0, "require failed");
        return "my func was called";
    }
}

contract Bar {
    event Log(string _message);
    event LogBytes(bytes _data);

    Foo public foo;

    constructor() {
        foo = new Foo(msg.sender);
    }

    function tryCatchExternalCall(uint _i) public {
        try foo.myFunc(_i) returns (string memory result) {
            emit Log(result);
        } catch {
            emit Log("external call failed");
        }
    }

    function tryCatchNewContract(address _owner) public {
        try new Foo(_owner) returns (Foo foo) {
            // you can use variable foo here
            emit Log("Foo created");
        } catch Error(string memory reason) {
            // catch failing recert() and require()
            emit Log(reason);
        } catch (bytes memory reason) {
            // catch failing assert()
            emit LogBytes(reason);
        }
    }
}
