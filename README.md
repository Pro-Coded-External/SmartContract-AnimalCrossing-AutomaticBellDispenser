<div align="center">
   <h1 align="center">Smart Contracts Automatic Bell Dispenser </h3>
   <h4 align="center">Bank System simulation in Animal Crossing Nintendo Game </h4> 
</div>
<br>
<div align="center">
  <a>
    <img  border-radius= 50 src="https://i.ebayimg.com/images/g/CnAAAOSwXOphsB8d/s-l400.jpg" width="400" height="400">
  </a>
</div>
<br>
<div align="center">
  
   ![tests](https://github.com/MatteoLeonesi/SmartContract-AnimalCrossing-BankSystem/actions/workflows/animalcrossing-bank-test.yml/badge.svg)

</div>

 

## About The Project
This project is composed by smart contracts that simulate Animal Crossing banking system, Animal Crossing is a social simulation video game series developed and published by Nintendo, where the user can buy and sell having also a bank account.We created smart contracts for 2 tokens inside the game, Bell & Miles (ERC20 standards), and 1 contract to simulate all game's functionalities. We also adding a script for deploy them and tests (obviously).

## Built With
* [Solidity](https://docs.soliditylang.org/en/v0.8.13/) 
* [Hardhat](https://hardhat.org/) 

<!-- GETTING STARTED -->
## Getting Started with Hardhat 

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
node scripts/TomNookATM.js
npx hardhat help
```
## Functionalities

### Bells & Miles (ERC20 standard)

**Nook Miles** are a type of currency in New Horizons that work similar to airline mileage programs in real life. Players earn Nook Miles from travel and participating in activities around the Deserted Island. Additionally, players can also get Nook Miles from completing tasks and stamp cards in the Nook Miles app section of the NookPhone. Since 500 Nook Miles can be redeemed for a 3,000 Bells voucher in the Nook Stop, 1 Nook Miles is worth 6 Bells. 
<p></p>

**Bells** are the main currency used in the Animal Crossing series. Although most frequently used to purchase items from stores and pay off the player's mortgage, Bells may also be used in several other respects, including trading with villagers and other services.

<div align="center">
  <a>
    <img  src="https://www.picclickimg.com/d/l400/pict/154869908101_/Animal-Crossing-New-Horizons-Bell-Nook-miles-ticket.jpg" width="350" height="210">
   <img  src="https://i.ebayimg.com/images/g/Tj8AAOSwebBenfnF/s-l400.jpg" width="350" height="210">
  </a>
</div>
<br>

```solidity
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

//Bell.sol

contract Bell is ERC20 {
    constructor() ERC20("Bell", "BLL") {
        _mint(msg.sender, 1000000 * (10**uint256(decimals())));
    }
}

//Miles.sol

contract Miles is ERC20 {
    constructor() ERC20("Miles", "MLS") {
        _mint(msg.sender, 100 * (10**uint256(decimals())));
    }
}


  ```
---

### Pay Debts

Mortgages are the number of Bells that the player owes Tom Nook for constructing and expanding their house. There are several mortgages to pay off.

<div align="center">
  <a>
    <img  border-radius= 50 src="https://static3.srcdn.com/wordpress/wp-content/uploads/2020/11/Animal-Crossing-New-Horizons-Home-Storage.jpg" width="400" height="200">
  </a>
</div>
<br>

```solidity
   
    address payable TomNook;
    // address => uint mapping so the contract can track debts for multiple users
    mapping(address => uint256) userDebt;
    
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
  ```

---
### Bell voucher Dex 

The Bell voucher is a new redeemable item in New Horizons. They can be redeemed from the Nook Stop in the Resident Services Tent or Building. They cost 500 Nook Miles, and are sold for 3,000 Bells. They have no uses other than as a way to convert Nook Miles into Bells.

<div align="center">
  <a>
    <img  border-radius= 50 src="https://cdn.guidestash.com/wp-content/uploads/2020/05/08224922/Bell-Voucher.jpg" width="400" height="200">
    <img  border-radius= 50 src="https://zephyrnet.com/wp-content/uploads/2020/05/how-to-use-bell-vouchers-animal-crossing-new-horizons-2.jpg" width="400" height="200">
  </a>
</div>
<br>

```solidity
    function BellVaucherDex(address _tokenAddress, uint256 _amount)
        external
        OnlyMilesForVaucher(_tokenAddress)
    {
        require(_amount > 499);
        accounts[msg.sender].balances[_tokenAddress] -= _amount;
        IERC20(_tokenAddress).transferFrom(TomNook, msg.sender, _amount * 6);
    }
  ```
---
### Automatic Bell Dispenser

interest is deposited into the player's savings on the first of each month 0.5% (0.05% in New Horizons). The ABD was first added in City Folk, and has appeared in all main series games since then.

<div align="center">
  <a>
    <img  border-radius= 50 src="https://animalcrossingworld.com/wp-content/uploads/2020/04/animal-crossing-new-horizons-bank-of-nook-savings-account-interest-rate-reduction.jpg" width="350" height="200">
  </a>
</div>
<br>

```solidity
    work in progress 
  ```
  
## Other Functionalities Added

 - Create Account 
 - Close Account
 - Deposit
 - Withdraw
 - Get Balance for each token 
 - accountExists, onlyValidTokens, OnlyMilesForVaucher Modifiers

---

## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**. 

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again! ❤️

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request


## Team

Matteo Leonesi - [Github](https://github.com/MatteoLeonesi) - matteo.leonesi@gmail.com

Nova - [Github](https://github.com/FoxDev12)

Emanuele Zini - [Github](https://github.com/Gr3it)





