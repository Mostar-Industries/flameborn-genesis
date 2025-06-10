// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.0/contracts/access/AccessControl.sol";

interface IFlameBornToken {
    function mint(address to, uint256 amount) external;
}

contract FlameBornMinter is AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    IFlameBornToken public immutable token;

    constructor(address tokenAddress, address admin) {
        require(tokenAddress != address(0), "Invalid token address");
        require(admin != address(0), "Invalid admin address");

        token = IFlameBornToken(tokenAddress);
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        _grantRole(MINTER_ROLE, admin);
    }

    function mint(address to, uint256 amount) external onlyRole(MINTER_ROLE) {
        token.mint(to, amount);
    }
}
