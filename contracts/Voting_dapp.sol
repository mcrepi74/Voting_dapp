// pragma solidity ^0.8.0;


// contract VotingSystem {
    
//     struct Candidate {
//         uint id;
//         string name;
//         uint voteCount;
//     }

//     mapping (uint => Candidate) public candidate;
//     mapping (address => bool) public voters;

//     uint public candidatesCount = 0;
//     uint public startTime;
//     uint public endTime;

//     event VotedEvent(uint indexed_candidateId);

//     constructor(uint _durationInMinutes){
//         startTime = block.timestamp;
//         endTime = startTime + (_durationInMinutes *1 minutes);

//         addCandidate("Bob");
//         addCandidate("Alice");

//     }

//     function addCandidate(string memory _name) private {
//         candidatesCount++;
//         candidates[candidatesCount]= Candidate(candidatesCount, _name, 0);
//     }

//     function vote(uint _candidateId) public{
//         require(block.timestamp >= startTime && block.timestamp <= endTime, "Voting is not allowed at this time.");
//         require(!voters[msg.sender],"You have already voted");
//         require(_candidateId> 0 && _candidateId <= candidatesCount, "You have entered an Invalid Id");

//         voters[msg.sender]= true;
//         candidates[_candidateId].voteCount++;
//         emit VotedEvent(_candidateId);
//     }

//     function getallCandidate() public view returns (Candidate memory){
//         Candidate[] memory candidateArray = new Candidate[](candidatesCount);
//         for (unint i)=1; i<= candidatesCount; i++){
//             candidateArray[i-1]= candidates[i];
//         }
//         return candidateArray;
//     }

//     function getCurrentleader() public view returns (string memory){
//             uint maxVotes =0;
//             uint leadingCandidateId = 0;

//             for(uint i= 1; i <= candidatesCount; i++){
//                 if(candidates[i].voteCount > maxVotes){
//                     maxVotes = candidates[i].voteCount;
//                     leadingCandidateId =i;
//                 }

//                 if(leadingCandidateId ==0){
//                     return "No votes cast yet!";
//                 }
//                 return candidates[leadingCandidateId.name];
//             }
//     }
// }

// Définit la version du compilateur Solidity à utiliser
pragma solidity ^0.8.0;

// Définit un contrat appelé VotingSystem
contract VotingSystem {
    
    // Structure pour représenter un candidat
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Mapping pour stocker les candidats par leur ID
    mapping (uint => Candidate) public candidates;
    
    // Mapping pour suivre si un électeur a voté ou non
    mapping (address => bool) public voters;

    // Compte total des candidats
    uint public candidatesCount = 0;

    // Temps de début et de fin des élections
    uint public startTime;
    uint public endTime;

    // Événement émis lorsqu'un vote a lieu
    event VotedEvent(uint indexed candidateId);

    // Constructeur du contrat, prend la durée des élections en minutes
    constructor(uint _durationInMinutes){
        // Enregistre le temps de début des élections
        startTime = block.timestamp;
        // Calcule le temps de fin en ajoutant la durée spécifiée
        endTime = startTime + (_durationInMinutes * 1 minutes);

        // Ajoute deux candidats par défaut
        addCandidate("Bob");
        addCandidate("Alice");
    }

    // Fonction interne pour ajouter un candidat
    function addCandidate(string memory _name) private {
        // Incrémente le nombre total de candidats
        candidatesCount++;
        // Ajoute le candidat à la mapping des candidats
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    // Fonction publique pour permettre à un électeur de voter pour un candidat
    function vote(uint _candidateId) public {
        // Vérifie si le vote est autorisé pendant la période d'élection
        require(block.timestamp >= startTime && block.timestamp <= endTime, "Voting is not allowed at this time.");
        // Vérifie si l'électeur n'a pas déjà voté
        require(!voters[msg.sender], "You have already voted");
        // Vérifie si l'ID du candidat est valide
        require(_candidateId > 0 && _candidateId <= candidatesCount, "You have entered an invalid Id");

        // Enregistre que l'électeur a voté
        voters[msg.sender] = true;
        // Incrémente le nombre de votes pour le candidat choisi
        candidates[_candidateId].voteCount++;
        // Émet l'événement de vote
        emit VotedEvent(_candidateId);
    }

    // Fonction pour récupérer tous les candidats
    function getAllCandidates() public view returns (Candidate[] memory) {
        // Initialise un tableau dynamique pour stocker tous les candidats
        Candidate[] memory candidateArray = new Candidate[](candidatesCount);
        // Boucle pour récupérer chaque candidat
        for (uint i = 1; i <= candidatesCount; i++) {
            candidateArray[i - 1] = candidates[i];
        }
        // Retourne le tableau de candidats
        return candidateArray;
    }

    // Fonction pour obtenir le candidat en tête
    function getCurrentLeader() public view returns (string memory) {
        // Variables pour suivre le candidat avec le plus de votes
        uint maxVotes = 0;
        uint leadingCandidateId = 0;

        // Boucle pour trouver le candidat en tête
        for (uint i = 1; i <= candidatesCount; i++) {
            if (candidates[i].voteCount > maxVotes) {
                maxVotes = candidates[i].voteCount;
                leadingCandidateId = i;
            }
        }

        // Si aucun vote n'a été émis, retourne un message indiquant cela
        if (leadingCandidateId == 0) {
            return "No votes cast yet!";
        }

        // Retourne le nom du candidat en tête
        return candidates[leadingCandidateId].name;
    }
}
