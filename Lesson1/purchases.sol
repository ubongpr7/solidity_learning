// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import {Pricing } from "./pricing.sol";
contract Purchases {
    Pricing[] public  listOfpricing;
    
    function createPricing()public {
       Pricing pricing=new Pricing();
       listOfpricing.push(pricing);

    }
    function calculateTotalPurchase(uint256 pricingIndex,uint256 totalQuantity) public view returns (uint256) {
     Pricing myPrice = listOfpricing[pricingIndex];
     return myPrice.calculateTotalPrice(totalQuantity);
    }

    // function getPrice(uint256 pricingIndex ) public {
    //  Pricing myPrice = listOfpricing[pricingIndex];


    // }
}