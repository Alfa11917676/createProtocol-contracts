// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
contract CreateProtocolPermissions is OwnableUpgradeable{
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    mapping( address => bool ) public minterList;
    mapping( address => bool ) public creatorList;

    modifier onlyMinter()  {
        require(minterList[msg.sender],"User not a minter");
        _;
    }

    modifier onlyCreator() {
        require(creatorList[msg.sender],"User not a creator");
        _;
    }

    function grantMinterRole(address _minter) public onlyOwner {
        minterList[_minter] = true;
    }

    function grantCreatorRole(address _creator) public onlyOwner {
        creatorList[_creator] = true;
    }

}