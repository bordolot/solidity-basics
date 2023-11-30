// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Visibility {
    string private privateVar = "my private varriable";
    string internal internalVar = "my intenral varriable";
    string public publicVar = "my public varriable";

    // function publicFunc() public pure returns (string memory) {
    //     return "public function called";
    // }

    function privateFunc() private pure returns (string memory) {
        return "private function called";
    }

    function testPrivateFunc() public pure returns (string memory) {
        return privateFunc();
    }

    function externalFunc() external pure returns (string memory) {
        return "external function called";
    }

    function internalFunc() internal pure returns (string memory) {
        return "internal function called";
    }

    function testInternalFunc() public pure virtual returns (string memory) {
        return internalFunc();
    }
}

contract ChildVisibility is Visibility {
    function testInternalFunc() public pure override returns (string memory) {
        return internalFunc();
    }
}
