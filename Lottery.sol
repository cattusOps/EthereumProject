pragma solidity ^0.5.8;

contract Lottery{
    address public manager; //anyone can execute initial time. or who want to play with also can open
    address payable[] public players; //players list storage as array. array can expand infinetly.=dynamic array
    
    constructor()public {
        manager = msg.sender; //the first manager is who send msg.
        
    }
    
    function enter() public payable {  //contract ether value is o.1ether or not confirm
        require(msg.value >= 20ether);
        require(msg.value <= 25ether); //prevention of winnerloss. to gathering smillar betting amount players
        players.push(msg.sender); 
    }
    
    function random() private view returns(uint){
        return uint(keccak256(abi.encodePacked(now,msg.sender,players.length)));
        
    }
    
    function pickWinner() public restricted{
        uint index = random()%players.length;
        players[index].transfer(address(this).balance);
        
    }

    modifier restricted{
        require(manager == msg.sender);
        _;                                    // yes
    
    } 
} 
