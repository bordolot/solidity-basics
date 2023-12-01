// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library Math {
    function sqrt(uint _y) internal pure returns (uint z) {
        if (_y > 3) {
            z = _y;
            uint x = _y / 2 + 1;
            while (x < z) {
                z = x;
                x = (_y / x + x) / 2;
            }
        } else if (_y != 0) {
            z = 1;
        }
    }
}

contract TestMath {
    function testSquareRoot(uint _x) public pure returns (uint) {
        return Math.sqrt(_x);
    }
}

library Array {
    function remove(uint[] storage _arr, uint _index) public {
        require(_arr.length > 0, "Can't remove from empty array");
        _arr[_index] = _arr[_arr.length - 1];
        _arr.pop();
    }
}

contract TestArray {
    using Array for uint[];

    uint[] public arr;

    function testArrayRemove() public {
        for (uint i = 0; i < 3; i++) {
            arr.push(i);
        }

        arr.remove(1);

        assert(arr.length == 2);
        assert(arr[0] == 0);
        assert(arr[1] == 2);
    }
}
