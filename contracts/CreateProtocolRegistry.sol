// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import { OwnableUpgradeable } from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import { ICreateProtocolPermissions } from "./Interface/ICreateProtocolPermissions.sol";
import { CreateProtocol } from "./CreateProtocol.sol";
import { ICreateProtocol } from "./Interface/ICreateProtocol.sol";

contract CreateProtocolRegistry is OwnableUpgradeable {

    event ProtocolDeployed(address indexed protocolAddress, address indexed creator);
    event GlobalComMinted(address indexed comProtocol, uint256 indexed id);

    ICreateProtocolPermissions public permissions;

    mapping (address => mapping (uint256 => uint256)) public globalCom;

    mapping (address => address[]) public comCollection;

    address public comProtocolTemplate;
    address[] public deployedProtocols;

    function initialize(address _permissions, address _comProtocolTemplate) public initializer {
        __Ownable_init();
        comProtocolTemplate = _comProtocolTemplate;
        permissions = ICreateProtocolPermissions(_permissions);
    }

    function updateComProtocolTemplate(address _comProtocolTemplate) public onlyOwner {
        comProtocolTemplate = _comProtocolTemplate;
    }

    /// todo: Use CreateProtocolPermissions to check if the caller has the permission to create a new COM Protocol.
    /// @notice Create a new COM Protocol
    /// @notice Deploys a new COM Protocol contract using `create2` and stores the address of the deployed contract.
    function createNewCOM() public  {
        bytes32 salt = keccak256(abi.encodePacked(msg.sender, block.timestamp));
        // Prepare the bytecode of the contract to deploy. Assuming `_comProtocolTemplate` contains the logic contract's address.
        // You might need to append constructor arguments after the bytecode.
        bytes memory bytecode = type(CreateProtocol).creationCode;

        // Deploy using create2. The `salt` ensures uniqueness, `0` is the amount of ETH sent along.
        address newProtocolAddress;
        assembly {
            newProtocolAddress := create2(0, add(bytecode, 0x20), mload(bytecode), salt)
        }
        require(newProtocolAddress != address(0), "Failed to deploy new protocol");

        ICreateProtocol(newProtocolAddress).updateComRegistry(address(this));
        // Store the address of the deployed contract
        deployedProtocols.push(newProtocolAddress);
        comCollection[msg.sender].push(newProtocolAddress);

        // Emit an event for the new deployment
        emit ProtocolDeployed(newProtocolAddress, msg.sender);
    }

    function getAllCOMCollections(address _userAddress) public view returns(address[] memory) {
        return comCollection[_userAddress];
    }

    function updateGlobalLedger(address _comProtocol, uint256 _id) public {
        globalCom[_comProtocol][_id] += 1;
        emit GlobalComMinted(_comProtocol, _id);
    }
}
