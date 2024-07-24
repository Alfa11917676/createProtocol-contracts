// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "./CreateProtocolPermissions.sol";
import "./Interface/ICreateProtocolPermissions.sol";
import "./Interface/ICOMRegistry.sol";

contract CreateProtocol is ERC1155 {

    event COMInitiated(address indexed _from, address indexed _to, uint256 _amount);
    error InvalidMinter(string mintersOnly);

    mapping (address => string[]) public comCollection;

    event ComInitiation(address indexed _caller, string _url);
    event ComFinalisation(address indexed _caller, uint256 _id, bytes _data);

    ICOMRegistry public comRegistry;

    constructor() ERC1155(""){}


    function comCreation(address _caller, string memory url) external {
            comCollection[_caller].push(url);
            emit ComInitiation(_caller, url);
    }

    function finaliseCOM(address to, uint256 id, bytes memory data) public {
        _mint(to, id, 1, data);
        emit ComFinalisation(to, 1, data);
    }

    function burn(address from, uint256 id, uint256 amount) public{
        _burn(from, id, amount);
    }
   

}