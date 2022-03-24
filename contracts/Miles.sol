// SPDX-License-Identifier: unlicense
pragma solidity ^0.8.4;


import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Miles is ERC20 {
    constructor() ERC20("Miles", "MLS") {
        _mint(msg.sender, 100 * (10**uint256(decimals())));
    }
}