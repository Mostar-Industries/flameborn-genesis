// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.0/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.0/contracts/token/ERC20/extensions/ERC20Votes.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.0/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.0/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.0/contracts/access/AccessControl.sol";

contract FlameBornToken is
    ERC20,
    ERC20Permit,
    ERC20Votes,
    ERC20Burnable,
    ERC20Pausable,
    AccessControl{
        
    string public constant name = "FlameBorn Token";
    string public constant symbol = "FLB";
    bytes32 public constant DEFAULT_ADMIN_ROLE = keccak256("DEFAULT_ADMIN_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER");
    bytes32 public constant FLAMEBORNTOKEN_DEFAULT_ADMIN_ROLE = 0x12345678;
    }
    using AccessControl for FlameBornToken;

    event MinterGranted(address indexed account);
    event PauserGranted(address indexed account);

    constructor(address admin)
        ERC20("FlameBorn Token", "FLB")
        ERC20Permit("FlameBorn Token")
    {
        require(admin != address(0), "Invalid admin address");
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        _grantRole(MINTER_ROLE, admin);
        _grantRole(PAUSER_ROLE, admin);
        _mint(admin, 1_000_000 ether);
    }

    function mint(address to, uint256 amount) external onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    function pause() external onlyRole(PAUSER_ROLE) {
        _pause();
    }

    function unpause() external onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    function grantMinter(address account) external onlyRole(DEFAULT_ADMIN_ROLE) {
        require(account != address(0), "Invalid address");
        _grantRole(MINTER_ROLE, account);
        emit MinterGranted(account);
    }

    function grantPauser(address account) external onlyRole(DEFAULT_ADMIN_ROLE) {
        require(account != address(0), "Invalid address");
        _grantRole(PAUSER_ROLE, account);
        emit PauserGranted(account);
    }

    // Override required due to multiple inheritance of _update from ERC20, ERC20Pausable, and ERC20Votes
    // Mark this function as virtual to avoid override errors
    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        override(ERC20, ERC20Pausable) // Correctly specify overridden contracts
    {
        super._beforeTokenTransfer(from, to, amount); // Call super function
    }

    // Override required for ERC20Votes and ERC20Burnable
    function _afterTokenTransfer(address from, address to, uint256 amount)
        internal
        override(ERC20Votes) // Correctly specify overridden contract
    {
        super._afterTokenTransfer(from, to, amount); // Call super function
    }

    function _mint(address to, uint256 amount)
        internal
        override(ERC20, ERC20Votes) // Correctly specify overridden contracts
    {
        super._mint(to, amount); // Call super function
    }

    function _burn(address account, uint256 amount)
        internal
        override(ERC20, ERC20Votes) // Correctly specify overridden contracts
    {
        super._burn(account, amount); // Call super function
    }

    function nonces(address owner)
        public
        view
        override(ERC20Permit)
        returns (uint256)
    {
        return super.nonces(owner);
    }
}