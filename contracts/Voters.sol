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

   


}