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
    }

    function test_flow() public {
    }
}
