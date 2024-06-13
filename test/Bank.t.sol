// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Bank} from "../src/Bank.sol";
import {MyContract} from "../src/MyContract.sol";

contract BankTest is Test {
    address user1;
    address user2;
    Bank bank;
    MyContract myContract;

    function setUp() public {
        user1 = vm.addr(1);
        user2 = vm.addr(2);
        bank = new Bank();
    }

    function test_flow() public {
    }
}
