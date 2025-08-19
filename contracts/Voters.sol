//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingSystem{
    
    address public admin;
    uint public canditatesCount;

    struct Canditate {
        string name;
        uint id;
        uint voteCount;
        bool voted;
    }

   mapping (uint => Canditate) public candidates;
   mapping(address => bool) public hasVoted;

   enum ElectionState{Notstarted, Ongoing, Ended}
   ElectionState public state;

   constructor(){
    admin = msg.sender;
    state = ElectionState
   }
   
   modifier onlyAdmin(){
    require(msg.sender == admin, "Not Admin")
   }

   function addCandidate(string memory _name)public onlyAdmin{
     canditatesCount++;
     candidates[canditatesCount] = Canditate(canditatesCount, _name, 0, voted)
   }

   function startElection() public onlyAdmin{
      require(state == ElectionState.Notstarted, 'Already Started')
      state = ElectionState.Ongoing;
   }

   function vote(uint _candidateId) public{
     require(state == ElectionState.Ongoing, 'Election not active');
     require(!hasVoted[msg.sender], 'Already Voted');
     require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate");

     hasVoted[msg.sender] = true;
     candidates[_candidateId].voteCount++;
   }

   function endELection() public onlyAdmin {
      require(state == ElectionState.Ongoing, "Not Active");
      state = ElectionState.Ended
   }

   function getWinner()public view returns(string memory winnerName){
     require(state = ElectionState.Ended, "Election not ended");

     uint winningVoteCount =0;
     uint winnerId = 0;

     for(uint i=1; i <= candidatesCount; i++){
        if(candidates[i].voteCount > winningVoteCount){
            winningVoteCount = candidates[i].voteCount;
            winnerId =i;
        }
     }
     winnerName = candidates[winnerId].name;
   }
}