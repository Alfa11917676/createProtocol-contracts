import { ethers } from "hardhat";
import hre from "hardhat";

async function main() {
  const createProtocolRegistry = await hre.ethers.getContractFactory(
    "CreateProtocolRegistry"
  );
  const CreateProtocolRegistry = await createProtocolRegistry.deploy();

  const createProtocol = await hre.ethers.getContractFactory("CreateProtocol");
  const CreateProtocol = await createProtocol.deploy();

  const createProtocolPermissions = await hre.ethers.getContractFactory(
    "CreateProtocolPermissions"
  );
  const CreateProtocolPermissions = await createProtocolPermissions.deploy();

  const deployedAddress = {
    CreateProtocolRegistry: CreateProtocolRegistry.target,
    CreateProtocol: CreateProtocol.target,
    CreateProtocolPermissions: CreateProtocolPermissions.target,
  };
  // console.log(deployedAddress);
}

async function verify(contractAddress: string, contructorArgs: any[]) {
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
