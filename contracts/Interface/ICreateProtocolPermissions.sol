// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface ICreateProtocolPermissions {

    function minterList(address) external view returns (bool);
    function creatorList(address) external view returns (bool);


}
