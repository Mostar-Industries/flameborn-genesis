// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/AccessControl.sol";

contract HealthActorRegistry is AccessControl {
    bytes32 public constant REGISTRAR_ROLE = keccak256("REGISTRAR_ROLE");

    mapping(address => bool) public verifiedActors;

    constructor(address admin) {
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        _grantRole(REGISTRAR_ROLE, admin);
    }

    function verifyActor(address actor) external onlyRole(REGISTRAR_ROLE) {
        verifiedActors[actor] = true;
    }

    function revokeActor(address actor) external onlyRole(REGISTRAR_ROLE) {
        verifiedActors[actor] = false;
    }

    function isVerified(address actor) external view returns (bool) {
        return verifiedActors[actor];
    }
}
