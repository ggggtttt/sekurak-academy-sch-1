// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract BankErc20 {
    mapping(address => uint) public balances;
    IERC20 public token;

    constructor(address _token) {
        token = IERC20(_token);
    }

    function deposit(uint256 amount, address beneficiary) public  {
        token.transferFrom(msg.sender, address(this), amount);
        balances[beneficiary] += amount;
    }

    /*function deposit(uint256 amount, address user, address beneficiary) public  {
        token.transferFrom(user, address(this), amount);
        balances[beneficiary] += amount;
    }*/

    function withdraw() public {
        uint balance = balances[msg.sender];
        require(balance > 0);

        token.transfer(msg.sender, balance);

        balances[msg.sender] = 0;
    }

    //Other functionality removed.
}

