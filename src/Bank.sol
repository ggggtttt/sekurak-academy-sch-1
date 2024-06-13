// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

//Source: https://hackernoon.com/hack-solidity-reentrancy-attack
//Source: https://solidity-by-example.org/hacks/re-entrancy/
contract Bank {
    mapping(address => uint) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        uint balance = balances[msg.sender];
        require(balance > 0);

        balances[msg.sender] = 0;

        (bool sent, ) = msg.sender.call{value: balance}("");
        require(sent, "Failed to send Ether");
    }

    //Other functionality removed.
}

