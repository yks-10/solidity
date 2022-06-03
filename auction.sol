// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
contract Auction {


    struct Asset {
        string name;
        string price;
        string description;
        address manufacturer;
        bool initialized;    
    }

    struct tracking{
        address location;
        string uuid;
    }

    address public owner;
    bool public canceled;
    address payable public beneficiary;
    uint public auctionEndtime;
    address public highestBidder;
    uint public highestBid;
    mapping(string => tracking) locations;
    mapping(string  => Asset) private assetStore;
    mapping(address => uint) public pendingReturns;
    bool ended = false;

    event HighestBidIncrease(address bidder, uint amount);
    event AuctionEnded(address winner, uint amount); 
    event AssetCreate(address manufacturer, string uuid, address location);
    event LogCanceled();

    function createAsset(string memory name, string memory price, string memory description, string memory uuid) public {
        require(!assetStore[uuid].initialized, "Asset With This UUID Already Exists");
        assetStore[uuid] = Asset(name, price, description, msg.sender,true);
        locations[uuid] = tracking(msg.sender, uuid);
        emit AssetCreate(msg.sender, uuid, msg.sender);
    }

    function getAssetDetails(string memory uuid)public view returns (string memory, string memory, string memory,address) {
        return (assetStore[uuid].name, assetStore[uuid].price, assetStore[uuid].description, assetStore[uuid].manufacturer);
    }

    constructor(uint _biddingTime, address payable _beneficiary, address payable _owner){
        beneficiary = _beneficiary;
        auctionEndtime = block.timestamp + _biddingTime;
        owner = _owner;
    }

    function auctionStatus() public view returns(string memory) {
        if(block.timestamp > auctionEndtime){
            return " ENDED";
        }
        if (block.timestamp < auctionEndtime){
            return "AUCTION STARTED";
        }
        else{
            return "NOT YET STARTED";
        }
    }

    function bid() public payable{
        if(canceled){
            revert("The auction is canceled");
        }

        if(block.timestamp > auctionEndtime){
            revert("The auction has already ended");
        }
        if(msg.value ==0){
            revert("Please provide a value greater than 0");
        }
        if (msg.value <= highestBid){
            revert("There is a already a higher or quaal bid");
        }
        if (highestBid !=0){
            pendingReturns[highestBidder] += highestBid;
        }
        highestBidder = msg.sender;
        highestBid = msg.value;
        emit HighestBidIncrease(msg.sender, msg.value);
    }

    function withdraw() public returns(bool){
        uint amount = pendingReturns[msg.sender];
        if( amount > 0){
            pendingReturns[msg.sender] = 0;
            if(!payable(msg.sender).send(amount)){
                pendingReturns[msg.sender] = amount;
                return false;
            }
        }
        return true;
    }

    function auctionEnd() public{
        if (block.timestamp < auctionEndtime){
            revert("The auction has not ended  yet");
        }
        if(ended){
            revert("The function auctionEnded has already been called");
        }
        ended = true;
        emit AuctionEnded(highestBidder, highestBid);
        beneficiary.transfer(highestBid);
    }

    function cancelAuction() onlyOwner  public returns(bool success)
    {
        canceled = true;
        emit LogCanceled();
        return true;
    }

    modifier onlyOwner {
        if (msg.sender != owner){
            revert("you can not cancel the auction");
        }
        _;
    }

}
