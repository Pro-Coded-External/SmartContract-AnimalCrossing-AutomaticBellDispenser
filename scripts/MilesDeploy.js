const hre = require("hardhat");

async function main() {
    const MilesToken = await hre.ethers.getContractFactory("Miles");
    console.log('Deploying Miles Token...');
    const token = await MilesToken.deploy();

    await token.deployed();
    console.log("Miles Token deployed to:", token.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });