// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract BemCandidate {
    struct Kandidat {
        string nama;
        string visi;
        uint256 suara;
    }
    
    Kandidat[] public kandidat;
    mapping(address => string) public pemilih;
    mapping(address => bool) public sudahMemilih;
    mapping(address => bool) public pemilihTerdaftar;
    
    uint256 public waktuMulai;
    uint256 public waktuSelesai;
    address public admin;
    
    event VoteCasted(address indexed voter, uint256 kandidatIndex);
    event KandidatAdded(string nama);
    
    //custom modifier untuk require
    modifier onlyDuringVoting() {
        require(
            block.timestamp >= waktuMulai && 
            block.timestamp <= waktuSelesai, 
            "Voting belum dimulai atau sudah selesai"
        );
        _;
    }

    modifier onlyVoter(){
        require(
            pemilihTerdaftar[msg.sender], "You haven't registered yet"
        );
        _;
    }

    modifier onlyCandidate(uint256 _urutan){
        require(_urutan < kandidat.length, "Index out of list");
        _;
    }


    // Mengatur buat nentuin berapa lama waktu voting berjalan
    function hourToSecond(uint256 _hour) public pure returns(uint256){
        return _hour * 3600;
    }
    
    function setVotingTime(uint256 _hourStart, uint256 _hourEnd) public {
        waktuMulai = block.timestamp + hourToSecond(_hourStart);
        waktuSelesai = block.timestamp + hourToSecond(_hourEnd);
    }


    // TODO: Implementasikan add candidate function
    function addCandidate(string memory _nama, string memory _visi) public{
        kandidat.push(Kandidat(_nama, _visi, 0)); 
    }

    //Lihat informasi candidate dari nomor urutan
    function getCandidateInfo(uint256 _index) public view returns(string memory, string memory, uint256){
        require(_index < kandidat.length, "Index out of list");
        return(kandidat[_index].nama, kandidat[_index].visi, kandidat[_index].suara);
    }

    //Lihat daftar candidate
    function getAllCandidate() public view returns(string[] memory){
        string[] memory candidateName = new string[](kandidat.length);
        for (uint256 i = 0; i < kandidat.length; ++i){
            candidateName[i] = kandidat[i].nama;
        }
        return candidateName;
    }
    


    // TODO: Implementasikan vote function
    function addVote(uint256 _index) public onlyDuringVoting onlyVoter onlyCandidate(_index){
        require(sudahMemilih[msg.sender] == false, "Kamu sudah memilih");

        sudahMemilih[msg.sender] = true;
        kandidat[_index].suara += 1;
    }

    // Registrasi pemilih
    function regisVoter(string memory _name) public{
        pemilih[msg.sender] = _name;
        pemilihTerdaftar[msg.sender] = true;
    }

    // untuk ngecek apakah voter sudah terdaftar atau belum
    function getVoter() public view returns(bool){
        return(pemilihTerdaftar[msg.sender]);
    }

    function indexOf(uint256[] memory arr, uint256 searchFor) private pure returns (int256) {
        for (uint256 i = 0; i < arr.length; i++) {
            if (arr[i] == searchFor) {
                return int256(i);
            }
        }
        return -1; // If the index is not found
    }


    // TODO: Implementasikan get results function
    string CurrentLeader;
    uint256[] public AllVote; 

    function getMaxVoteIndex() public view returns(int256){
        // Menghitung nilai max yang ada di array
        uint256 maxSuara = kandidat[0].suara;
        uint256 maxIndex = 0;
        for (uint256 i = 0; i < kandidat.length; i++) {
            if (kandidat[i].suara > maxSuara) {
                maxSuara = kandidat[i].suara;
                maxIndex = i;
            }
        }   

        // Mendapatkan index ke berapa dari jumlah vote yang max
        return int256(maxIndex);
    }

    function getCurrentLeader() public view returns(string memory){     
        // int256 idx = getMaxVoteIndex();
        // require(idx >= 0, "There's no candidate");

        uint256 index = uint256(getMaxVoteIndex());
        return kandidat[index].nama;
    }
    
    function getVoteCount(uint256 _urutan) public onlyCandidate(_urutan) view returns(uint256){
        return kandidat[_urutan].suara;
    }

}