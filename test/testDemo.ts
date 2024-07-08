import {
  time,
  loadFixture,
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("Create Protocol Contract", function () {
  it("Should return the correct value", async function () {
    const [owner] = await ethers.getSigners();
    const TestContract = await ethers.getContractFactory("CreateProtocol");
    const permissionContract = await ethers.getContractFactory(
      "CreateProtocolPermissions"
    );
    const permContract = await permissionContract.deploy();
    const contract = await TestContract.deploy();
    const to = "0xE27806E7e6dA8700DFfa95E6cf09a9879c5616d0";
    console.log("hii 2");
    console.log(owner);

    await contract.mint(to, 1, 1, "");
  });
});
