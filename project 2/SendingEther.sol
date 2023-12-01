// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
Two ways of sending Ether

                        send Ether
                            |
                    msg.data is empty?
                    /               \
                yes              no
                /                  \
            receive() exists?           fallback()
                /         \
            yes            no
            /               \
        receive()           fallback()

*/

contract ReceiveEther {
    // Function to receive Ether. msg.data must be empty
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract SendEther {
    function sendViaTransfer(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function sendViaSend(address payable _to) public payable {
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }

    function sendViacALL(address payable _to) public payable {
        // (bool sent, bytes memory data) = _to.call{value: msg.value}("");
        (bool sent, ) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
}
