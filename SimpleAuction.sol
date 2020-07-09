pragma solidity ^0.5.8;
contract SimpleAuction{
    /*data sector */
    address payable public beneficiary; //first line. smart contract 처음배포자 
    uint public auctionEnd;
    
    address public highestBidder;
    
    uint public highestBid;
    mapping (address => uint) pendingReturn;
    bool ended;
    
    event HighestBidIncreased(address bidder, uint amount);
    event AuctionEnded(address winner, uint amount);
    
    /*function*/ // ABI, s.c address ****important***
    
    
    constructor(uint _biddingTime, address payable _beneficiary) public{   //생성자가 있으면 디플로이할때 뭔갈 줘야된다
        beneficiary = _beneficiary;
        auctionEnd = now + _biddingTime;
    }
    
    function bid() public payable{
        require(now <=auctionEnd);
        require(msg.value > highestBid);
        if(highestBid!=0){
            pendingReturn[highestBidder] += highestBid;   //리턴 리턴즈 오타조심 맞추기
        }
        highestBidder = msg.sender;
        highestBid = msg.value;
        emit HighestBidIncreased(msg.sender, msg.value);
    }
    function withdraw() public returns(bool){
        uint amount = pendingReturn[msg.sender];
        if(amount>0){
            pendingReturn[msg.sender] = 0;
            if(!msg.sender.send(amount)){
                pendingReturn[msg.sender] = amount;
                return false;
            }   
        }
        return true;
    }
    function auctionEnd_t() public {
        require(now >= auctionEnd);
        require(!ended);  
        ended = true;
        emit AuctionEnded(highestBidder, highestBid);
        beneficiary.transfer(highestBid);         // 주석처리해보고 다시 디플로이 //스캠에 당하지말자 ㅋㅋㅋ trans5er lol
    }
}

//잘안될땐 F5 매직을 쓴다
//컴파일, 각 계정별 주소 복사해서 잘 붙여넣고
//bidding
//컴퓨터 설정에따라 비딩타임 분, 초, 등 다양하므로 맞춰야함 
//case2. 각기 다른 ether로 bidding 후 withdraw로 제대로 낙찰자에게 갔는가 확인
//no wei
