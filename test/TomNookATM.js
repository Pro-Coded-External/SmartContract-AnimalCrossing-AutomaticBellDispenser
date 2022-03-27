

const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("TomNook ATM contract", function () {

    let Token;
    let hardhatToken;
    let owner;
    let addr1;
    let addr2;
    let addrs;


    beforeEach(async function () {
        TomNookATM = await ethers.getContractFactory("TomNookATM");
        const BELL = await ethers.getContractFactory("Bell");
        const MILES = await ethers.getContractFactory("Miles");
        [owner, addr1, addr2, ...addrs] = await ethers.getSigners();
        const Bell = await BELL.deploy();
        const Miles = await MILES.deploy();
        hardhatToken = await TomNookATM.deploy(Bell.address, Miles.address);
    });


    describe("Account Creation", function () {
        it("should created a new Villager account", async () => {
            await hardhatToken.connect(addr1).createAccount();
            await expect(hardhatToken.connect(addr1).createAccount()).to.be.revertedWith(
                "TomNook ATM:: Already have an account"
            );
        });
    });
});