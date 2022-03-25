// SPDX-License-Identifier: unlicense
pragma solidity ^0.8.4;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TomNookATM {
    address payable TomNook;
    uint256 TomNook_Debts = 5696000; //biggest house
    uint256 deployDate;
    IERC20 miles;
    IERC20 bell;
    
    constructor(address bellToken, address milesToken) {
        TomNook = payable(msg.sender);
        deployDate = block.timestamp;
        miles = IERC20(milesToken);
        bell = IERC20(bellToken);
    }
    struct Account {
        bool exists;
        address[] currentTokenAddresses;
        mapping(address => uint256) balances;
    }

    mapping(address => Account) private accounts;

    modifier accountExists() {
        require(accounts[msg.sender].exists, "TomNook ATM: Account not Exists");
        _;
    }

    /** Add control for check if there is bells or miles  */
    function createAccount(address tokenAddress) external {
        require(
            !accounts[msg.sender].exists,
            "TomNook ATM:: Already have an account"
        );
        //require(tokenAddress == 0x5FbDB2315678afecb367f032d93F642f64180aa3);
        console.log("msg.sender : ", msg.sender);
        accounts[msg.sender].exists = true;
    }

    /** Both accounts need to exist in the bank system  */
    function deposit(address _tokenAddress, uint256 _amount)
        external
        accountExists
    {
        //tracking
        accounts[msg.sender].balances[_tokenAddress] += _amount;
        //transfer
        IERC20(_tokenAddress).transferFrom(msg.sender, address(this), _amount);
    }

    function withdraw(address tokenAddress, uint256 amount)
        external
        accountExists
    {
        // If user tries to withdraw more than what he deposited then transfer all their balance.
        if (amount > accounts[msg.sender].balances[tokenAddress]) {
            amount = accounts[msg.sender].balances[tokenAddress];
        }
        // Sets the amount BEFORE transferring out to prevent exploits (for more info, look up reentrancy attacks and the check-effect-interaction pattern)
        accounts[msg.sender].balances[tokenAddress] -= amount;
        IERC20(tokenAddress).transfer(msg.sender, amount);
    }

    function getBalance(address _tokenAddress)
        external
        view
        accountExists
        returns (uint256 balance)
    {
        return accounts[msg.sender].balances[_tokenAddress];
    }

    function closeAccount() external accountExists {
        for (
            uint256 i;
            i < accounts[msg.sender].currentTokenAddresses.length;
            i++
        ) {
            if (
                accounts[msg.sender].balances[
                    accounts[msg.sender].currentTokenAddresses[i]
                ] != 0
            ) {
                revert("TomNook: Account not empty");
            }
        }
        accounts[msg.sender].exists = false;
    }

    //animal crossing bank system has a stake system
    function interests() external view {
        require(block.timestamp >= (deployDate + 30 days));
    }

    //with miles in animal crossinga villager can buy BuySpecialAssets
    function buySpecialFornitures() external {}

    //pay debts to tom
    function paydebts(address _tokenAddress, uint256 _amount) external {
        if (TomNook_Debts == 0) {
            console.log(
                "extinguished debts! Congratulations ! you have finished paying your home loan !  "
            );
        } else {
            //tracking
            accounts[msg.sender].balances[_tokenAddress] -= _amount;
            TomNook_Debts -= accounts[msg.sender].balances[_tokenAddress];
            //transfer
            IERC20(_tokenAddress).transferFrom(msg.sender, TomNook, _amount);
        }
    }
}
