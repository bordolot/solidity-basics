// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IDetectionBot {
    function handleTransaction(address user, bytes calldata msgData) external;
}

contract DetectionBot is IDetectionBot {
    address private forbiddenAddress;

    constructor(address _forbiddenAddress) {
        forbiddenAddress = _forbiddenAddress;
    }

    function handleTransaction(
        address user,
        bytes calldata msgData
    ) external override {
        (address to, uint256 value, address origSender) = abi.decode(
            msgData[4:],
            (address, uint256, address)
        );
        if (origSender == forbiddenAddress) {
            Forta(msg.sender).raiseAlert(user);
        }
    }
}

interface IForta {
    function setDetectionBot(address detectionBotAddress) external;

    function notify(address user, bytes calldata msgData) external;

    function raiseAlert(address user) external;
}

contract Forta is IForta {
    mapping(address => IDetectionBot) public usersDetectionBots;
    mapping(address => uint256) public botRaisedAlerts;

    function setDetectionBot(address detectionBotAddress) external override {
        usersDetectionBots[msg.sender] = IDetectionBot(detectionBotAddress);
    }

    function notify(address user, bytes calldata msgData) external override {
        if (address(usersDetectionBots[user]) == address(0)) return;
        try usersDetectionBots[user].handleTransaction(user, msgData) {
            return;
        } catch {}
    }

    function raiseAlert(address user) external override {
        if (address(usersDetectionBots[user]) != msg.sender) return;
        botRaisedAlerts[msg.sender] += 1;
    }
}
