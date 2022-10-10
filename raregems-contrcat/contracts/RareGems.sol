// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import './Gems.sol';

contract RareGems{
    
        Gems gem;
        address token;
        address marketPlaceOwner;
        uint private productID=0;
        mapping(uint=>Product) public products;
        mapping (address=>uint) public user; 
        
        //Product Structure
        struct Product{
            uint id;
            uint price;
            string name;
            string description;
            address payable owner;
            bool thirdPartyCheck;
        }
        //event to be called on creation of product in the blockchain
        event productCreated(
            uint id,
            uint price,
            string name,    
            string description,
            address payable owner,
            bool thirdPartyCheck
        );
        //event to be called on purchase of product in the blockchain
        event productPurchased(
            uint id,
            uint price,
            string name,
            string description,
            address payable owner,
            bool thirdPartyCheck
        );


        // modifiers
        modifier onlyMarketPlaceOwner{ 
            require(msg.sender==marketPlaceOwner,"Only Market Place Owner can perform this operation");
            _;
         }
         modifier onlyUser{ 
            require(user[msg.sender]==1||user[msg.sender]==2,"Please register");
            _;
        }

        modifier onlyOwner(uint id){
            require(msg.sender == products[id].owner,"Only owner of the product can delete the product");
            _;
        }

        modifier onlyPrimeMember{
            require(user[msg.sender]==2,"Please become a prime member");
            _;
        }
    

    constructor (address Token) { 
    token = Token;
    marketPlaceOwner=msg.sender;
    user[msg.sender]=1; 
    gem = Gems(token);
    }

    
    function viewBalance() public view returns(uint256) {
        return gem.balanceOf(msg.sender);
    }

    function viewProducts(uint id) public view onlyUser returns(uint,uint,string memory,string memory,address,bool){
        return(products[id].id,products[id].price,products[id].name,products[id].description,products[id].owner,products[id].thirdPartyCheck);
    }

    function register (bool isPrimeUser) public payable {
        address member =msg.sender;
        if(isPrimeUser){
            user[member]=2;
        }
        else
        {
            user[member]=1;
        }
    }
        
   function unregister (address payable member_unreg) onlyMarketPlaceOwner public {

        user[member_unreg]=0;  

    }
    

    function createPrimeProduct(string memory _name, string memory _description,  uint _price) onlyPrimeMember public {

        require(bytes(_name).length > 0);
        require(bytes(_description).length > 0);
        require(_price>(10));
        //Create a product
        productID ++;
        products[productID]= Product(productID, _price,_name,_description, payable(msg.sender),true);
        
        // Trigger an event
        emit productCreated(productID, _price*(10**18),_name,_description, payable(msg.sender),true);
        
    }

    //contract to create a Item and add to blockchain, if any user wants to buy can see it and buy it.
    function createProduct(string memory _name, string memory _description,  uint _price) onlyUser public {
        require(bytes(_name).length > 0);
        require(bytes(_description).length > 0);
        require(_price>0);
        require(_price<=(10));
        
        //Create a product
        productID ++;
        products[productID]= Product(productID, _price,_name,_description, payable(msg.sender),false);
        
        // Trigger an event
        emit productCreated(productID, _price*(10**18),_name,_description, payable(msg.sender),false);
        
    }



    function purchasePrimeProduct(uint _id) onlyPrimeMember public payable{
        Product memory _product = products[_id];
        address payable _seller= products[_id].owner; 

        require(_product.thirdPartyCheck == true);
        //Verify the product id:
        require(_product.id>=0 && _product.id<=productID);
        require(msg.value>=_product.price," Value is less than the product price");
        require(_seller!=msg.sender);

        gem.transferFrom(products[_id].owner, msg.sender, products[_id].price);
        products[_id].owner=payable(msg.sender);

        emit productPurchased(_id, _product.price,_product.name,_product.description, payable(msg.sender),true);
    }

 
    function purchaseProduct(uint _id) onlyUser public payable{

        address payable _seller= products[_id].owner;

        require(_seller!=msg.sender);

        gem.transferFrom(msg.sender,products[_id].owner, products[_id].price);

        products[_id].owner=payable(msg.sender);

        emit productPurchased(_id, products[_id].price,products[_id].name,products[_id].description, products[_id].owner,false);

    }

    function deleteProduct(uint _id) onlyOwner(_id) public{
        //Delete Product using the id
        delete products[_id];

    }


}


