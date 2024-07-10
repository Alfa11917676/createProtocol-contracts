// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "@openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol";
import "./CreateProtocolPermissions.sol";

contract CreateProtocol is ERC1155Upgradeable,CreateProtocolPermissions{

    constructor() {
        _transferOwnership(msg.sender);
        grantMinterRole(msg.sender);
    }
    
   function grantMinterRole(address _minter) public onlyOwner{
        minterList[_minter] = true;
    }

    function mint(address to, uint256 id, uint256 amount, bytes memory data) public onlyMinter{
        _mint(to, id, amount, data);
    }

    function burn(address from, uint256 id, uint256 amount) public{
        _burn(from, id, amount);
    }
   

}