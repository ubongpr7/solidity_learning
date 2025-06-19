// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter{
    
    function getPrice() internal view returns (uint256) {
        AggregatorV3Interface priceFeed=AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,)=priceFeed.latestRoundData(); //1e8=10^8 
        // uint256 value=price * (10**12);
        return uint256(price *1e8);
    }
    function getConversionRate(uint256 ethAmount) internal view returns (uint256) {
        uint256 price=getPrice();
        uint256 ethAmountInUSD=(ethAmount*price)/1e18;
        return ethAmountInUSD;
    }
}