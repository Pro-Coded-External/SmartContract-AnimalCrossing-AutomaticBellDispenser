async function main() {
    const TomNookATM = await hre.ethers.getContractFactory("TomNookATM");
    console.log('Deploying TomNookATM...');
    const bank = await TomNookATM.deploy();

    await bank.deployed();
    console.log("TomNookATM deployed to:", bank.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });