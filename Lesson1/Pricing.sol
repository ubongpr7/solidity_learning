// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Pricing{
    uint256 DefaultunitPrice=30;
    struct Product{
        string name;
        uint256 price;
    }
    Product public pepsi = Product("Pepsi",25);
    Product public coke = Product({name:"Coke", price:25});
    // dynamic array
    Product[] public listOfProducts;
    // array of fixed length
    Product[3] public listOf3Products;
    function calculateTotalPrice(uint unitsSold) public view returns(uint){
        return unitsSold*DefaultunitPrice;
    }
    // mappings is likened to dict in python
    mapping(string =>uint256) public  nameToProductsPrice;

    // calldata, memory, storage: we use them to specify the type of string
    // calldata variables are temp and cant be modified
    // function addProducts(string calldata name_, uint256 price_ ) public{

    // storage variables are permanent and cant be modified
    // function addProducts(string storage name_, uint256 price_ ) public{
        // u cant use storage in a function, it is wrong

    // memory variables are temp and can be modified: used for struct,
    //  mapping and arrays need to be given d memory keyword and string is an array of bytes
    function addProducts(string memory name_, uint256 price_ ) public{
        // name_="pepsi";
        // add to array of product
        listOfProducts.push(Product(name_,price_)); // same as pepsi = Product("Pepsi",25)
        //add to maping of products with price
        nameToProductsPrice[name_]=price_; 
    }
    

}

