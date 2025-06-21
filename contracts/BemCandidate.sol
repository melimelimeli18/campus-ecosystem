// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract PemilihanBEM {
    struct Kandidat {
        string nama;
        string visi;
        uint256 suara;
    }
    
    Kandidat[] public kandidat;
    mapping(address => bool) public sudahMemilih;
    mapping(address => bool) public pemilihTerdaftar;
    
    uint256 public waktuMulai;
    uint256 public waktuSelesai;
    address public admin;
    
    event VoteCasted(address indexed voter, uint256 kandidatIndex);
    event KandidatAdded(string nama);
    
    modifier onlyDuringVoting() {
        require(
            block.timestamp >= waktuMulai && 
            block.timestamp <= waktuSelesai, 
            "Voting belum dimulai atau sudah selesai"
        );
        _;
    }
    
    // TODO: Implementasikan add candidate function
    function addCandidate(string memory _nama, string memory _visi) public{
        kandidat.push(Kandidat(_nama, _visi, 0));
    }

    function getCandidateInfo(uint256 _index) public view returns(string memory, string memory, uint256){
        require(_index < kandidat.length, "Index out of list");
        return(kandidat[_index].nama, kandidat[_index].visi, kandidat[_index].suara);
    }

    function getAllCandidate() public view returns (Kandidat[] memory){
        return kandidat;
    }

    // TODO: Implementasikan vote function
    function addVote(string memory _nama) public {
        // kandidat.suara += 1;
    }


    // TODO: Implementasikan get results function
}