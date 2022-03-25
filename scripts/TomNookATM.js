
async function main() {
    const Bell = await hre.ethers.getContractFactory("Bell");
    const Miles = await hre.ethers.getContractFactory("Miles");
    const TomNookATM = await hre.ethers.getContractFactory("TomNookATM");
    console.log('Deploying contracts...');
    const bell = await Bell.deploy();
    await bell.deployed();
    const miles = await Miles.deploy();
    await miles.deployed();
    const bank = await TomNookATM.deploy(bell.address, miles.address);
    await bank.deployed();
    console.log("Bells token deployed at:", bell.address);
    console.log("Miles token deployed at:", miles.address);
    console.log("TomNookATM deployed to:", bank.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });