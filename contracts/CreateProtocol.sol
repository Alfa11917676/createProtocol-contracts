// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "./CreateProtocolPermissions.sol";
import "./Interface/ICreateProtocolPermissions.sol";

contract CreateProtocol is ERC1155 {

    error InvalidMinter(string mintersOnly);

    constructor() ERC1155(""){}

    function mint(address to, uint256 id, uint256 amount, bytes memory data) public {
        _mint(to, id, amount, data);
    }

    function burn(address from, uint256 id, uint256 amount) public{
        _burn(from, id, amount);
    }
   

}