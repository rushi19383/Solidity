pragma solidity 0.4.25;

contract Bank{

    uint bal;

    constructor() public
    {
        bal = 1;
    }

    function getBalance() view public returns(uint){
        return bal;
    }

    function withdraw(uint amt) public{
        bal = bal - amt;
    }

    function deposit(uint amt) public{
        bal = bal + amt;
    }
}