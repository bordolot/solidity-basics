// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Vault {
    //slot 0
    uint public number = 123;
    //slot 1
    bool public boo = false;
    address public addr = msg.sender;
    uint16 public smallNum = 23;
    //slot 2
    bytes32 private password;

    //constants do not use storage
    uint public constant someConst = 99;

    //slots 3,4,5
    bytes32[3] public data;

    struct User {
        uint id;
        bytes32 password;
    }

    // slot 6 - length of array
    // starting from slot hash(6) - array elements
    // slot where array element is stored = keccak256(slot)) + (index * elementSize)
    // where slot = 6 and elementSize = 2 (1 (uint) +  1 (bytes32))
    User[] private users;

    // slot 7 - empty
    // entries are stored at hash(key, slot)
    // where slot = 7, key = map key
    mapping(uint => User) private idToUser;

    constructor(bytes32 _password) {
        password = _password;
    }

    function addUser(bytes32 _password) public {
        User memory user = User({id: users.length, password: _password});

        users.push(user);
        idToUser[user.id] = user;
    }

    function getArrayLocation(
        uint slot,
        uint index,
        uint elementSize
    ) public pure returns (uint) {
        return uint(keccak256(abi.encodePacked(slot))) + (index * elementSize);
    }

    function getMapLocation(uint slot, uint key) public pure returns (uint) {
        return uint(keccak256(abi.encodePacked(key, slot)));
    }
}

/*
slot 0 - count
web3.eth.getStorageAt("0x534E4Ce0ffF779513793cfd70308AF195827BD31", 0, console.log)
slot 1 - u16, isTrue, owner
web3.eth.getStorageAt("0x534E4Ce0ffF779513793cfd70308AF195827BD31", 1, console.log)
slot 2 - password
web3.eth.getStorageAt("0x534E4Ce0ffF779513793cfd70308AF195827BD31", 2, console.log)

slot 6 - array length
getArrayLocation(6, 0, 2)
web3.utils.numberToHex("111414077815863400510004064629973595961579173665589224203503662149373724986687")
Note: We can also use web3 to get data location
web3.utils.soliditySha3({ type: "uint", value: 6 })
1st user
web3.eth.getStorageAt("0x534E4Ce0ffF779513793cfd70308AF195827BD31", "0xf652222313e28459528d920b65115c16c04f3efc82aaedc97be59f3f377c0d3f", console.log)
web3.eth.getStorageAt("0x534E4Ce0ffF779513793cfd70308AF195827BD31", "0xf652222313e28459528d920b65115c16c04f3efc82aaedc97be59f3f377c0d40", console.log)
Note: use web3.toAscii to convert bytes32 to alphabet
2nd user
web3.eth.getStorageAt("0x534E4Ce0ffF779513793cfd70308AF195827BD31", "0xf652222313e28459528d920b65115c16c04f3efc82aaedc97be59f3f377c0d41", console.log)
web3.eth.getStorageAt("0x534E4Ce0ffF779513793cfd70308AF195827BD31", "0xf652222313e28459528d920b65115c16c04f3efc82aaedc97be59f3f377c0d42", console.log)

slot 7 - empty
getMapLocation(7, 1)
web3.utils.numberToHex("81222191986226809103279119994707868322855741819905904417953092666699096963112")
Note: We can also use web3 to get data location
web3.utils.soliditySha3({ type: "uint", value: 1 }, {type: "uint", value: 7})
user 1
web3.eth.getStorageAt("0x534E4Ce0ffF779513793cfd70308AF195827BD31", "0xb39221ace053465ec3453ce2b36430bd138b997ecea25c1043da0c366812b828", console.log)
web3.eth.getStorageAt("0x534E4Ce0ffF779513793cfd70308AF195827BD31", "0xb39221ace053465ec3453ce2b36430bd138b997ecea25c1043da0c366812b829", console.log)
*/
