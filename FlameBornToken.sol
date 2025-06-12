// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { ERC20Burnable } from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import { AccessControl } from "@openzeppelin/contracts/access/AccessControl.sol";

/// @title FlameBorn Token (FLB)
/// @notice ERC-20 token with minting, burning, and access control.
/// @dev Built with OpenZeppelin 5.0.0 contracts. Deployed for Flameborn Network initiatives.
contract FlameBornToken is ERC20, ERC20Burnable, AccessControl {
    /// @notice Hash of the role that allows minting
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    /**
     * @notice Deploys the FLB token and assigns roles.
     * @param admin The address that will be granted DEFAULT_ADMIN_ROLE and MINTER_ROLE.
     */
    constructor(address admin) ERC20("FlameBorn Token", "FLB") {
        require(admin != address(0), "Admin cannot be zero address");

        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        _grantRole(MINTER_ROLE, admin);

        // Optional: Mint initial supply for bootstrap operations
        _mint(admin, 1_000_000 * 10 ** decimals());
    }

    /**
     * @notice Mint new FLB tokens to a specified address.
     * @dev Only callable by accounts with MINTER_ROLE.
     * @param to Address receiving the tokens.
     * @param amount Token amount to mint (in wei).
     */
    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    /**
     * @notice Returns true if this contract implements the interface defined by interfaceId.
     * @param interfaceId The interface identifier.
     * @return True if interface is supported.
     */
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
