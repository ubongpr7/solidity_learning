// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;
import {PriceConverter} from "utilities/PriceConverter.sol";

// get funds from users
// withdraw funds
// set the minimum fund in USD
error NotOwner();
contract Fundme{
    using  PriceConverter for uint256;
    uint256 public constant MINIMUM_USD=5e18;
    address[] funders;
    mapping(address funder => uint256 amount) public  addressToAmountFunded;
    address public immutable i_owner;
    // constructors are used to initialise variables in smart contracts
    constructor(){
        i_owner=msg.sender;
    }
    function fund()public payable  {
        // require(msg.value>100) to set minimum value of wei; 1 ETH = 1e18 wei
        // when tx fails every state before the tx become reverted

        require(msg.value.getConversionRate()>MINIMUM_USD);
        // require(PriceConverter.getConversionRate(msg.value)>minimumFundUSD);
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender]+= msg.value;
        // tx fields
        // Nonce: tx count for the acct
        // Gas Price: price per unit of gas in Wei
        // Gas Limit: max gas that tx can use
        // To: to address of receiver
        // Value: amount of wei for this tx 
        // Data: data bytes that can be read or modified in the tx
        // v,r,s:components of tx signature
    }
    function withdraw()public onlyOwner{
        // require(msg.sender == owner);
        for (uint256 funderIndex=0;funderIndex<funders.length;funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder]=0;
        }
        funders =new address[](0);
        //withdrawing the actual funds via transfer,send,call
        // transfer: uses max 2300 gas and it exceeds it will throw error
        // typecast msg.sender(an address) to payable
        // payable(msg.sender).transfer(address(this).balance);

        // send: uses max of 2300 gas, if it fails, it returns bool
        // bool sendSuccess=payable(msg.sender).send(address(this).balance);
        // require(sendSuccess,"cannot withdraw from the fund");

        // call: forwards all gases, if it fails, it returns bool and the value in bytes
        (bool success,)= payable(msg.sender).call{value:address(this).balance}("");
        require(success,"Call Failed");
    }
    function getfunds() public view returns (uint){
        // address 0x694AA1769357215DE4FAC081bf1f309aDC325306
    }
    
    function setminimumfund(uint _amount)public{}
    modifier onlyOwner{
        
        // require(msg.sender == i_owner, "Caller is not the Owner");
        // custom error messages for gas optimisation
        if (msg.sender !=i_owner){revert NotOwner();}
        _;
    }
}