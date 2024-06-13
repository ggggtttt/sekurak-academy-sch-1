// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {BankErc20} from "../src/BankErc20.sol";
import {MockERC20} from "../src/Mocks/MockERC20.sol";

contract BankErc20Test is Test {
    address tokenOwner;
    address user1;
    address user2;
    BankErc20 bank;
    MockERC20 token;

    function setUp() public {
        user1 = vm.addr(1);
        user2 = vm.addr(2);
        tokenOwner = vm.addr(3);
        token = new MockERC20();
        bank = new BankErc20(address(token));

        assertEq(token.balanceOf(user1),0);

        vm.prank(tokenOwner);
        token.mint(user1, 1 ether);

        assertEq(token.balanceOf(user1), 1 ether);

    }

    function test_flow() public {
        assertEq(token.balanceOf(user1), 1 ether);
        assertEq(token.balanceOf(address(bank)), 0);

        vm.prank(user1);
        token.approve(address(bank), 1 ether);
        vm.prank(user2);
        bank.deposit(1 ether, user1, user2);
        vm.prank(user1);
        vm.expectRevert();
        bank.deposit(1 ether, user1, user1);

        assertEq(token.balanceOf(user1), 0);
        assertEq(token.balanceOf(address(bank)),1 ether);
    }
}
