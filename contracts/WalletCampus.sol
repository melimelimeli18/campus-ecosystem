// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract WalletCampus{
    mapping(address => uint) public balance;
    //"address" : "0";

    //deposit
    function deposit(uint _saldo) public{
        balance[msg.sender] += _saldo; 
    }

    //cek saldo
    function getBalance() public view returns(uint){
        return balance[msg.sender];
    }
    //withdraw
    function withDrawBalance(uint _saldo) public{
        balance[msg.sender] -= _saldo;
    }
    //transfer
    function transfer(address _to,uint _saldo) public{
        balance[msg.sender] -= _saldo;
        balance[_to] += _saldo;
    }
}