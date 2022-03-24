

const { expect } = require("chai");

describe("Token contract", function () {

    let Token;
    let hardhatToken;
    let owner;
    let addr1;
    let addr2;
    let addrs;


    beforeEach(async function () {
        Token = await ethers.getContractFactory("TomNookATM");
        [owner, addr1, addr2, ...addrs] = await ethers.getSigners();
        hardhatToken = await Token.deploy();
    });


    describe("Account Creation", function () {

        const tokenAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3"

        it("should created a new Villager account", async () => {
            await hardhatToken.connect(addr1).createAccount(tokenAddress);
            await expect(hardhatToken.connect(addr1).createAccount(tokenAddress)).to.be.revertedWith(
                "TomNook ATM:: Already have an account"
            );
        });
    });
});