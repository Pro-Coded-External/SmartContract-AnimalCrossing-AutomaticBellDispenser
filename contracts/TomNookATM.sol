// SPDX-License-Identifier: unlicense
pragma solidity ^0.8.4;


import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract TomNookATM {

    address payable TomNook;

    struct Account{
        bool exists;
        address[] currentTokenAddress;
        mapping(address => uint256) balances;
    }

    mapping(address => Account) private accounts;

    constructor(){
        TomNook = payable(msg.sender);
    }

   modifier accountExists {
        require(accounts[msg.sender].exists, "TomNook ATM: Account not Exists");
        _;
    }

   function createAccount(address tokenAddress) external payable {
        require(!accounts[msg.sender].exists, "TomNook ATM:: Already have an account");
        //require(tokenAddress == 0x5FbDB2315678afecb367f032d93F642f64180aa3);
        console.log("msg.sender : ", msg.sender);
        accounts[msg.sender].exists = true;
    }
   
}
