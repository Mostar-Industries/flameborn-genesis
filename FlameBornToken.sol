// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title FlameBorn Token (FLB)
/// @notice A mintable, burnable, and access-controlled ERC20 token built for the Flameborn impact network.
/// @dev Uses OpenZeppelin contracts via GitHub URL imports for Remix compatibility.

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.0/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.0/contracts/access/AccessControl.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.0/contracts/token/ERC20/ERC20.sol";

contract FlameBornToken is ERC20, ERC20Burnable, AccessControl {
    /// @notice Role identifier for accounts allowed to mint new tokens.
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    /// @notice Creates the FLB token and grants roles to the deployer.
    /// @param admin The address that will hold admin and minter roles.
    constructor(address admin) ERC20("FlameBorn Token", "FLB") {
        require(admin != address(0), "Admin address cannot be zero");

        // Grant admin full control
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        _grantRole(MINTER_ROLE, admin);
    }

    /// @notice Mints new FLB tokens to a specified address.
    /// @dev Only callable by addresses with the MINTER_ROLE.
    /// @param to The recipient address.
    /// @param amount The amount to mint (in wei).
    function mint(address to, uint256 amount) external onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }
}
