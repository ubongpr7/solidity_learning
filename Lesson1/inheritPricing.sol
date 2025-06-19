// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Pricing} from "./pricing.sol";

contract inheritPricing is Pricing {
    uint public discount=10;
    function calculateTotalPrice(uint unitsSold) public view override  returns (uint) {
        return DefaultunitPrice*unitsSold-discount;
    }
}