// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ResumeVerification {
    address public admin;

    struct Resume {
        string ipfsHash;
        bool isVerified;
    }

    mapping(address => Resume) public resumes;

    event ResumeSubmitted(address indexed user, string ipfsHash);
    event ResumeVerified(address indexed user, string ipfsHash);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function submitResume(string calldata ipfsHash) external {
        resumes[msg.sender] = Resume(ipfsHash, false);
        emit ResumeSubmitted(msg.sender, ipfsHash);
    }

    function verifyResume(address user) external onlyAdmin {
        require(bytes(resumes[user].ipfsHash).length != 0, "Resume not submitted");
        resumes[user].isVerified = true;
        emit ResumeVerified(user, resumes[user].ipfsHash);
    }

    function isResumeVerified(address user) external view returns (bool) {
        return resumes[user].isVerified;
    }
}
