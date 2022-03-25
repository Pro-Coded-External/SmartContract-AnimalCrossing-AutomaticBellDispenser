// SPDX-License-Identifier: unlicense
pragma solidity ^0.8.4;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TomNookATM {
    address payable TomNook;
    // address => uint mapping so the contract can track debts for multiple users
    mapping(address => uint256) userDebt;

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
    // You need to add this modifier to some (all?) of the functions
    modifier onlyValidTokens(address tokenAddress) {
        require(
            tokenAddress == address(miles) || tokenAddress == address(bell),
            "TomNookATM: Wrong token"
        );
        _;
    }

    /** Add control for check if there is bells or miles  */
    function createAccount(address tokenAddress) external {
        require(
            !accounts[msg.sender].exists,
            "TomNook ATM:: Already have an account"
        );
        // Since we now use a mapping to track the debt, we need to initialize it when the user creates an account
        userDebt[msg.sender] == 5696000;
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

    //pay debts to tomx
    function paydebts(address _tokenAddress, uint256 _amount)
        external
        accountExists
    {
        if (userDebt[msg.sender] == 0) {
            console.log(
                "extinguished corredebts! Congratulations ! you have finished paying your home loan !  "
            );
        } else {
            //tracking
            accounts[msg.sender].balances[_tokenAddress] -= _amount;

            // Focus lmao
            // TomNook_Debts -= accounts[msg.sender].balances[_tokenAddress];

            // Correct with the previous implementation (without the mapping)
            // TomNook_Debts -= _amount;
            userDebt[msg.sender] -= _amount;
            //transfer
            IERC20(_tokenAddress).transfer(TomNook, _amount);
        }
    }
}
