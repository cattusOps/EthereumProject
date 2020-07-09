pragma solidity ^0.5.8;


contract Greeter
{
    
    address creator; 
    string greeting;
    
    constructor(string memory _greeting) public{
        creator = msg.sender;
        greeting = _greeting; //greeting 초 기 값 설 정 
        
    }
    
    function greet() public view returns(string memory){
        return greeting;
        
    }
    
    function setGreeting(string memory _newgreeting) public{
        greeting = _newgreeting;
        
    }
    
}
