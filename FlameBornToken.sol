// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { ERC20Burnable } from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import { AccessControl } from "@openzeppelin/contracts/access/AccessControl.sol";

/// @title FlameBorn Token (FLB)
/// @notice Minimal and secure BEP-20 implementation with minting and burning.
/// @dev Uses OpenZeppelin v5.0.0. No unbounded storage ops.
contract FlameBornToken is ERC20, ERC20Burnable, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    /**
     * @notice Constructor to initialize FLB and set admin + minter roles.
     * @param admin Address that will hold admin and minter rights.
     */
    constructor(address admin) ERC20("FlameBorn Token", "FLB") {
        require(admin != address(0), "Admin address cannot be zero");
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        _grantRole(MINTER_ROLE, admin);
    }

    /**
     * @notice Mints FLB tokens to a given address.
     * @dev Caller must have MINTER_ROLE.
     * @param to Address receiving the minted tokens.
     * @param amount Amount of tokens (in wei) to mint.
     */
    function mint(address to, uint256 amount) external onlyRole(MINTER_ROLE) {
        _mint(to, amount); // Safe bounded write
    }
}
