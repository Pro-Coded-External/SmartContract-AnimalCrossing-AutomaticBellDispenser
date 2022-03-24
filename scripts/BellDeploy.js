const hre = require("hardhat");

async function main() {
    const BellToken = await hre.ethers.getContractFactory("Bell");
    console.log('Deploying Bell Token...');
    const token = await BellToken.deploy();

    await token.deployed();
    console.log("Bell Token deployed to:", token.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });