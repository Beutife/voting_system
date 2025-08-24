//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingSystem {
    
    address public admin;
    uint public candidatesCount;

    struct Candidate {
        string name;
        uint id;
        uint voteCount;
    }

    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public hasVoted;

    enum ElectionState { Notstarted, Ongoing, Ended }
    ElectionState public state;

    constructor() {
        admin = msg.sender;
        state = ElectionState.Notstarted;
    }
   
    modifier onlyAdmin() {
        require(msg.sender == admin, "Not Admin");
        _;
    }

    function addCandidate(string memory _name) public onlyAdmin {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(_name, candidatesCount, 0);
    }

    function startElection() public onlyAdmin {
        require(state == ElectionState.Notstarted, "Already Started");
        state = ElectionState.Ongoing;
    }

    function vote(uint _candidateId) public {
        require(state == ElectionState.Ongoing, "Election not active");
        require(!hasVoted[msg.sender], "Already Voted");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate");

        hasVoted[msg.sender] = true;
        candidates[_candidateId].voteCount++;
    }

    function endElection() public onlyAdmin {
        require(state == ElectionState.Ongoing, "Not Active");
        state = ElectionState.Ended;
    }

    function getWinner() public view returns(string memory winnerName) {
        require(state == ElectionState.Ended, "Election not ended");

        uint winningVoteCount = 0;
        uint winnerId = 0;

        for(uint i = 1; i <= candidatesCount; i++) {
            if(candidates[i].voteCount > winningVoteCount) {
                winningVoteCount = candidates[i].voteCount;
                winnerId = i;
            }
        }

        winnerName = candidates[winnerId].name;
    }
}
