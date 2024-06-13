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

        console.log(user1, user1.balance);
        console.log(user2, user2.balance);

        assertEq(user1.balance, 0);
        assertEq(user2.balance, 0);

        vm.deal(user1, 1 ether); // 1 * 10 **18
        vm.deal(user2, 10 ether);

        console.log(user1, user1.balance);
        console.log(user2, user2.balance);

        assertEq(user1.balance, 1 ether);
        assertEq(user2.balance, 10 ether);
    }

    function test_sc_flow() public {
        vm.prank(user1);
        myContract = new MyContract(address(bank));

        assertEq(user1.balance, 1 ether);
        assertEq(address(bank).balance, 0 ether);

        vm.prank(user2);
        bank.deposit{value: 10 * 10**18}();

        vm.prank(user1);
        myContract.deposit{value: 1 * 10**18}();

        assertEq(user1.balance, 0 ether);
        assertEq(address(bank).balance, 11 ether);

        vm.prank(user1);
        myContract.withdraw();

        assertEq(user1.balance, 11 ether);
        assertEq(address(bank).balance, 0 ether);
    }

    function test_flow() public {
        assertEq(user1.balance, 1 ether);
        assertEq(address(bank).balance, 0 ether);

        vm.prank(user1);
        bank.deposit{value: 1 * 10**18}();

        assertEq(user1.balance, 0 ether);
        assertEq(address(bank).balance, 1 ether);

        vm.prank(user1);
        bank.withdraw();

        assertEq(user1.balance, 1 ether);
        assertEq(address(bank).balance, 0 ether);

        //vm.prank(user2);
        //bank.withdraw();
    }
}
