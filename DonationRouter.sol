// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

interface IHealthActorRegistry {
    function isVerified(address actor) external view returns (bool);
}

interface IFlamebornToken {
    function mint(address to, uint256 amount) external;
}

contract DonationRouter is ReentrancyGuard {
    IHealthActorRegistry public registry;
    IFlamebornToken public token;
    uint256 public donationRate; // FLB per native token

    constructor(address registryAddr, address tokenAddr, uint256 rate) {
        registry = IHealthActorRegistry(registryAddr);
        token = IFlamebornToken(tokenAddr);
        donationRate = rate;
    }

    function donate(address recipient) external payable nonReentrant {
        require(msg.value > 0, "Must send donation");
        require(registry.isVerified(recipient), "Recipient not verified");

        (bool sent,) = recipient.call{value: msg.value}("");
        require(sent, "Transfer failed");

        uint256 mintAmount = msg.value * donationRate;
        token.mint(msg.sender, mintAmount);
    }
}
