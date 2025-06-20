// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

//To DO: Bagaimana cara mengimplementasikan itu modifier, menggunakna require. Belajar gas fee optimization

contract StudentRegistry {
    struct Mahasiswa {
        string nama;
        uint256 nim;
        string jurusan;
        uint256[] nilai; //array
        bool isActive;
    }
    
    //uint sebagai nim.
    mapping(uint256 => Mahasiswa) public mahasiswa;
    mapping(address => bool) public authorized;
    uint256[] public daftarNIM;
    
    event MahasiswaEnrolled(uint256 nim, string nama);
    event NilaiAdded(uint256 nim, uint256 nilai);
    
    //event buat getInfo mahasiswa

    modifier onlyAuthorized() {
        require(authorized[msg.sender], "Tidak memiliki akses");
        _;
    }
    
    constructor() {
        authorized[msg.sender] = true;
    }
    
    // TODO: Implementasikan enrollment function
    function enrollment(string memory _nama, uint256 _nim, string memory _jurusan) public {
        mahasiswa[_nim].nama = _nama;
        mahasiswa[_nim].nim = _nim;
        mahasiswa[_nim].jurusan = _jurusan;
        mahasiswa[_nim].isActive = true;
        authorized[msg.sender] = true;
        emit MahasiswaEnrolled(_nim, _nama);
        
    }
    
    // TODO: Implementasikan add grade function
    function setGrade(uint256 _nim, uint256 _nilai) public {
        //Menolak input jika nilai lebih dari 100, dan Mahasiswa tidak terdafar
        require(_nilai <= 100 && mahasiswa[_nim].isActive == true, "Mahasiswa harus terdaftar dan nilai maksimal 100!");
        mahasiswa[_nim].nilai.push(_nilai);
        emit NilaiAdded(_nim, _nilai);
    }

    // TO DO: Implementasi update grade
    function updateGrade(uint256 _nim, uint256 _index, uint256 _nilaiBaru) public{
        // ambil nim lalu index. Ganti dengan input yang baru 
        require(_nilaiBaru <= 100 && mahasiswa[_nim].isActive == true, "Mahasiswa harus terdaftar dan nilai maksimal 100!");
        mahasiswa[_nim].nilai[_index] = _nilaiBaru;
    }

    // Read Grade mahasiswa berdasarkan index
    //returns mengambil input nim, lalu mengembalikan array dari data NILAI. 
    //kenapa array? karena di struct sudah di inisialisasi kalau nilai bisa menyimpan data dalam bentuk banyak atau array.
    function getGrade(uint256 _nim) public view returns(uint256[] memory){
        return mahasiswa[_nim].nilai;
    }


    // TODO: Implementasikan get student info function
    function getStudent(uint _nim) public view returns(string memory, string memory, uint256[] memory){
        require(mahasiswa[_nim].isActive == true, "Mahasiswa tidak terdaftar di Kampus ini!");
        return (mahasiswa[_nim].nama, mahasiswa[_nim].jurusan, mahasiswa[_nim].nilai);
    }

    // TODO: Validasi Status 
    function isActiveStudent(uint _nim) public view returns (bool){
        return mahasiswa[_nim].isActive;
    }
}