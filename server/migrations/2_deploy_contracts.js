const CryptoCards = artifacts.require("CryptoCards");
const PlasmaCash = artifacts.require("PlasmaCash");
const ValidatorManagerContract = artifacts.require("ValidatorManagerContract");

module.exports = async function(deployer, network, accounts) {

    deployer.deploy(ValidatorManagerContract).then(async () => {
        const vmc = await ValidatorManagerContract.deployed();
        console.log(`ValidatorManagerContract deployed at address: ${vmc.address}`);

        // FIXME error happened while deploying PlasmaCash contract.
        await deployer.deploy(PlasmaCash, vmc.address);
        const root = await PlasmaCash.deployed();
        console.log(`RootChain deployed at address: ${root.address}`);

        await deployer.deploy(CryptoCards, root.address);
        const cards = await CryptoCards.deployed();
        console.log(`CryptoCards deployed at address: ${cards.address}`);

        await vmc.toggleToken(cards.address);
    });
};

