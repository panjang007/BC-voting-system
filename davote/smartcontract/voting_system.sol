// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingSystem {

    // Mapping of candidate IDs to their names
    mapping(uint256 => string) public candidates;

    // Mapping of voter addresses to their eligibility status
    mapping(address => bool) public eligibleVoters;

    // Mapping of voter addresses to their voting status (true if voted)
    mapping(address => bool) public votedAddresses;

    // Mapping of candidate IDs to their vote count
    mapping(uint256 => uint256) public votesPerCandidate;


    constructor() {
        // Define candidates and their IDs
        candidates[1] = "Abu Zharr";
        candidates[2] = "Aiman Isa";
        candidates[3] = "Afiq Azman";

        // Add specific addresses (or logic for adding voters) to eligibleVoters
        eligibleVoters[address(0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB)] = true;
        eligibleVoters[address(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4)] = true;
        eligibleVoters[address(0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db)] = true;
        // ... add more voters or update logic to dynamically add ...
    }

    // Function to check if a voter is valid (eligible)
    function isValidVoter(address voter) public view returns (bool) {
        return eligibleVoters[voter];
    }

    // Function to get candidate names by ID
    function getCandidateName(uint256 candidateID) public view returns (string memory) {
        return candidates[candidateID];
    }

     // Function for a valid voter to cast their vote for a candidate
    function castVote(uint256 candidateID) public {
        require(isValidVoter(msg.sender), "Not a valid voter");
        require(!votedAddresses[msg.sender], "Already voted");
        votesPerCandidate[candidateID]++;
        votedAddresses[msg.sender] = true;
    }

     function getWinner() public view returns (uint256, string memory) {
        uint256 winningVoteCount = 0;
        uint256 winningCandidateID = 0;
        for (uint256 candidateID = 1; candidateID <= 3; candidateID++) {
            if (votesPerCandidate[candidateID] > winningVoteCount) {
                winningVoteCount = votesPerCandidate[candidateID];
                winningCandidateID = candidateID;
            }
        }
        return (winningVoteCount, getCandidateName(winningCandidateID));
    }


}
