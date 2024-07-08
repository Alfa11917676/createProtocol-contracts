// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
contract CreateProtocolPermissions is OwnableUpgradeable{
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    mapping(address=>bool) public minterList;

    modifier onlyMinter()  {
        require(minterList[msg.sender],"User not a minter");
        _;
    }

}