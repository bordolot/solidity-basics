// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Array {
    uint[] public arr;
    uint[] public arr2 = [1, 2, 3];
    uint[10] public myFixedArrey;

    function get(uint _i) public view returns (uint) {
        return arr[_i];
    }

    function getArr() public view returns (uint[] memory) {
        return arr;
    }

    function pushIntoArray(uint _i) public {
        arr.push(_i);
    }

    function removeLastFromArray() public {
        arr.pop();
    }

    function getLength() public view returns (uint) {
        return arr.length;
    }

    function removeByIndex(uint _index) public {
        delete arr[_index];
    }

    // function examples() external pure {
    //     uint[] memory a = new uint[](5);
    // }
}

contract ArrayRemoveByShifting {
    // [1,2,3] -- remove(1) --> [1,3,3] -> [1,3]

    uint[] public arr;

    function remove(uint _index) public {
        require(_index < arr.length, "index out of bound");
        for (uint i = _index; i < arr.length - 1; i++) {
            arr[i] = arr[i + 1];
        }
        arr.pop();
    }

    function test() external {
        arr = [1, 2, 3, 4, 5];
        remove(2);
        // [1,2,4,5]
        assert(arr[0] == 1);
        assert(arr[1] == 2);
        assert(arr[2] == 4);
        assert(arr[3] == 5);
        assert(arr.length == 4);

        arr = [1];
        remove(0);

        // []

        assert(arr.length == 0);
    }
}

contract ArrayReplaceFromEnd {
    uint[] public arr;

    // deleting an element creates a gap in the array
    // so move the last element into the place to delete

    function getWholeArr() public view returns (uint[] memory) {
        return arr;
    }

    function remove(uint _index) public {
        arr[_index] = arr[arr.length - 1];
        arr.pop();
    }

    function test() public {
        arr = [1, 2, 3, 4];
        remove(1);
        // arr = [1, 4, 3]
        // assert(arr.length == 3);
        // assert(arr[0] == 1);
        // assert(arr[1] == 4);
        // assert(arr[2] == 3);
    }
}
