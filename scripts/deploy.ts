import { ethers } from "hardhat";

async function main() {
    let contractAddress = "0xDf47B98a74401c6c3FfE7110b4B6D8ee3FC01aa5"
    const CreateProtocol = await ethers.getContractFactory("CreateProtocol");
    const createProtocol = await CreateProtocol.deploy();
    await createProtocol.waitForDeployment();
    console.log("Create Protocol Deployed");
    console.log("Address of the COM", createProtocol.target);

    let com = await createProtocol.comCreation("0xE27806E7e6dA8700DFfa95E6cf09a9879c5616d0", "0x0000000000000000000000009fb0a3cdf1a5cd56ed32fb58f4b9468aebbb2db0");
    await com.wait();
    console.log("Com Creation Done");

    let tx = await createProtocol.finaliseCOM("0xE27806E7e6dA8700DFfa95E6cf09a9879c5616d0", 1, "0x0000000000000000000000009fb0a3cdf1a5cd56ed32fb58f4b9468aebbb2db0");
    await tx.wait();
    console.log("Minted");

}

async function verify(contractAddress:string, contructorArgs:any[]) {
  await hre.run("verify:verify", {
    address: contractAddress,
    constructorArguments: [contructorArgs],
  });
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
