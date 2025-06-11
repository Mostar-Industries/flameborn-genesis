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
    AccessControl
{
    bytes32 public constant MINTER_ROLE = keccak256("MINTER");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER");

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

    // Only need to override the "most derived" contracts for each hook.
    function _update(address from, address to, uint256 value)
    internal
    virtual
        override(ERC20, ERC20Pausable, ERC20Votes)
    {
        super._update(from, to, value);
    }

    function _afterTokenTransfer(address from, address to, uint256 amount)
        internal
        virtual
        override(ERC20, ERC20Pausable, ERC20Votes)
    {
        super._afterTokenTransfer(from, to, amount);
    }

    function _mint(address to, uint256 amount)
        internal
        virtual
        override(ERC20, ERC20Pausable, ERC20Votes)
    {
        super._mint(to, amount);
    }

    function _burn(address account, uint256 amount)
        internal
        virtual
        override(ERC20, ERC20Pausable, ERC20Votes)
    {
        super._burn(account, amount);
    }

    // OpenZeppelin v5: nonces is in Nonces, not ERC20Permit
    function nonces(address owner)
        public
        view
        override(Nonces)
        returns (uint256)
    {
        return super.nonces(owner);
    }
}
