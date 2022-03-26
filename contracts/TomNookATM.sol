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

    modifier onlyValidTokens(address tokenAddress) {
        require(
            tokenAddress == address(miles) || tokenAddress == address(bell),
            "TomNookATM: Wrong token"
        );
        _;
    }

    modifier OnlyMilesForVaucher(address _tokenAddressMiles) {
        require(
            _tokenAddressMiles == address(miles),
            "TomNookATM: Wrong token, only Miles"
        );
        _;
    }

    function createAccount(address _tokenAddress)
        external
        onlyValidTokens(_tokenAddress)
    {
        require(
            !accounts[msg.sender].exists,
            "TomNook ATM:: Already have an account"
        );
        // Since we now use a mapping to track the debt, initialization when the user creates an account
        userDebt[msg.sender] == 5696000;
        console.log("msg.sender : ", msg.sender);
        accounts[msg.sender].exists = true;
    }

    //both account need to exist in the bbank system
    function deposit(address _tokenAddress, uint256 _amount)
        external
        accountExists
        onlyValidTokens(_tokenAddress)
    {
        //tracking
        accounts[msg.sender].balances[_tokenAddress] += _amount;
        //transfer
        IERC20(_tokenAddress).transferFrom(msg.sender, address(this), _amount);
    }

    function withdraw(address _tokenAddress, uint256 amount)
        external
        accountExists
        onlyValidTokens(_tokenAddress)
    {
        // If user tries to withdraw more than what he deposited then transfer all their balance.
        if (amount > accounts[msg.sender].balances[_tokenAddress]) {
            amount = accounts[msg.sender].balances[_tokenAddress];
        }
        // Sets the amount BEFORE transferring out to prevent exploits (for more info, look up reentrancy attacks and the check-effect-interaction pattern)
        accounts[msg.sender].balances[_tokenAddress] -= amount;
        IERC20(_tokenAddress).transfer(msg.sender, amount);
    }

    function getBalance(address _tokenAddress)
        external
        view
        accountExists
        onlyValidTokens(_tokenAddress)
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
        //require(block.timestamp >= (deployDate + 30 days));
    }

    //pay debts to mr TomNook
    function paydebts(address _tokenAddress, uint256 _amount)
        external
        accountExists
        onlyValidTokens(_tokenAddress)
    {
        if (userDebt[msg.sender] == 0) {
            console.log(
                "extinguished corredebts! Congratulations ! you have finished paying your home loan !  "
            );
        } else {
            //tracking
            accounts[msg.sender].balances[_tokenAddress] -= _amount;
            userDebt[msg.sender] -= _amount;
            IERC20(_tokenAddress).transfer(TomNook, _amount);
        }
    }

    //convert miles to bell (bell vaucher ), 500 miles -> 3000 bells
    function BellVaucherDex(
        address _tokenAddressBels,
        address _tokenAddressMiles,
        uint256 _amount
    ) external OnlyMilesForVaucher(_tokenAddressMiles) {
        accounts[msg.sender].balances[_tokenAddressMiles] -= _amount;
        IERC20(_tokenAddressBels).transferFrom(
            TomNook,
            msg.sender,
            _amount * 6
        );
        accounts[msg.sender].balances[_tokenAddressBels] += _amount * 6;
    }
}
