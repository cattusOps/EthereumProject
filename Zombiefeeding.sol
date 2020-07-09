pragma solidity ^0.4.19; 


import "./ZombieFactory.sol";


contract Zombiefeeding is ZombieFactory {

    function feedingandMutiply (uint _zombieId, uint_targetDna, string _species) public {
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = Zombies[_zombieId]; //storage는 블록체인에 기록, 먹이를 먹은 좀비 아이디 기록한다

        _targetDna = _targetDna % dnaModulus;
        uint newDna = (myZombie.dna + _targetDna) / 2; //좀비의 객체에서 좀비에 디엔에이값만 취할떄. 이름이면 myZombie.name
        
        if (keccak256(_species) == keccak256("kitty")) {
            newDna = newDna - newDna % 100 + 99;
        }
        _createZombie("Noname",newDna)//좀비팩토리의 함수 호출~~~
        
    }

    function feedOnKitty(uint _zombieId, uint _kittyId) public {
        uint kittyDna;
        
        (,,,,,,,,,kittyDna) = kittyContract.getkitty_kittyDna,"kitty");
        
        //키티 디엔에이를 만들고 , 그 아이디를 받아서 키티 컨트랙트에서 겟키트 함수를 써서 아이디를 입력받아서
//값들을 반환하고, 고양이 정보가 담긴 내용을 받는다. 반환
//반환값이 10개니까 

        ㄹfeedandMultyply(_zombieId)
        
    }
    
    
}
