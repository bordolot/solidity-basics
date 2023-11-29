// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

contract ErrorHandlig {
    bool result;

    function checkInput(uint256 _input) public pure returns (string memory) {
        require(_input >= 0, "invalid uint: too low");
        require(_input <= 255, "invalid uint: too high");
        return "input is uint8";
    }

    function Odd(uint256 _input) public pure returns (bool) {
        require(_input % 2 != 0);
        return true;
    }

    function checkOverFlow(uint256 _num1, uint256 _num2) public {
        uint256 sum = _num1 + _num2;
        assert(sum <= 255);
        result = true;
    }

    // function getResult() public view returns (string memory) {
    //     if (result == true) {
    //         return "no overflow";
    //     } else {
    //         return "overflow exist";
    //     }
    // }

    function checkOverflow(
        uint256 _num1,
        uint256 _num2
    ) public pure returns (string memory, uint) {
        uint sum = _num1 + _num2;

        if (sum < 0 || sum > 255) {
            revert("overflow occured");
        } else {
            return ("no overflow", sum);
        }
    }
}
