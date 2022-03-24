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

      function deposit(address tokenAddress, uint256 amount) external payable accountExists {
       
    }

    function tokenExists(address account, address tokenAddress) internal view returns(bool) {
       
    }

    function withdraw(address tokenAddress, uint256 amount) external accountExists {

    }

    function closeAccount() external accountExists {
        
    }
    
    function getBalance(address account, address tokenAddress) external view accountExists returns(uint256 balance) {
        
    } 

    //animal crossing bank system has a stake system
    function stake() external {
        
    } 

     //with miles in animal crossinga villager can buy BuySpecialAssets
    function buySpecialFornitures() external{
        
    } 

     //pay debts to tom
   function paydebts() external {
        
    } 
   
}
