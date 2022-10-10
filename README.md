# Blockchain

1. Title of the Project:
Celebrity autographed products. (Marketplace name: Raregems and Token name: Gems)


2.  Issues Addressed:
1.Authenticity of the product.
2.Transparency of the history of the product
3.Genuineness of the product.
4.Easy access to authentic rare items to user.


3. Abstract:
When an authentic rare item is sold in any marketplace, we don’t know the genuineness and
authenticity of that item. The user who is buying this item can be duped by receiving a duplicate
of that item at the cost of the original item. Many users in real life have been scammed by such
tricks. By using ERC20 token, we will keep the transaction history as well as the authenticity of
the product transparent to the end user. This will help user in buying original product at its true
value. We can achieve this by maintaining the history of the transactions made on that product
in blockchain from the day it was listed on the marketplace.
The buyer can search any rare product he is interested in, and if product is available, it will be
displayed to the user. He can check the authenticity of the product by checking the transaction
history of that specific product along with the verified mark which will indicate the quality of the
product. He can place the order and make payment using 'GEMS' token (ERC20 token). Once the
payment is made, ownership is transferred to the buyer and the transaction history is stored in
blockchain.
The seller can add the product along with the level of quality check done by the seller. Once seller
receives payment, the ownership is transferred for the product



Short Description of each data structure, modifier, function:
Data structures, mappings and events:
1. address marketPlaceOwner: This is the address of the owner of the marketplace.
2. Uint productid: Used to keep the counter of the products and used as key while adding or
deleting products
3. Mapping products: To map product ID with Product structure of each product.
4. Mapping user: For registration of users to the marketplace.
5. Struct Product: For storing all the details of the product.
6. Event Product Created: To record the transaction on blockchain whenever product is created.
7. Event Product Purchased: To record the transaction on blockchain whenever product is
purchased.
Modifiers:
8. Modifier onlyMarketPlaceOwner: To check if the user performing the operation is the owner
of the marketplace else it will generate error.
9. Modifier onlyUser: To check if the user performing the operation is registered in the
marketplace.
10. Modifier onlyOwner: To check if the user performing the operation is the owner of the
product on which the operation is performed.
11. Modifier onlyPrimeMember: To check if the user performing the operation is the prime
member.
Functions:
12. Register(): To register the user to the marketplace.
13. viewProducts(): To view the product based on the id of the product.
14. UnRegister(): To unregister the user from the marketplace.
15. CreatePrimeProduct(): For entering prime product in the marketplace.
Unique Functionality – Only prime members can add prime products. Prime products are
the one which have gone through third party check and are on the expensive side of rare
items.
Prime users are registered during Register function.
16. CreateProduct(): For entering products in the marketplace.
17. purchasePrimeProduct(): For purchasing prime products.
Unique Functionality – Only prime members can buy this products. User should be
registered as prime user.
18. purchaseProduct(): For purchasing products from the marketplace.
19. deleteProduct(): For deleting the product from the marketplace.



Detailed explanation of ERC 20 functionality and methods:

I have implemented our ERC 20 token ‘GEM’ in gems.sol file. 
have added all the methods which are 
required for an ERC 20 token.
An ERC20 is a standard which is followed by many smart contracts and abide by them. It allows smart contracts 
which follow this standard to act as a token similarly like Ethereum. A smart contract which follows this standard 
is called ERC 20 token.
ERC20 defines functions such as totalSupply, transfer, transferFrom, balanceOf, approve and allowance. 
I have written an interface IERC20 which contains all the method definitions of ERC20 standard which we will 
be implementing when we implement this interface in our code.


Overall Deployment process of contract and Dapp connection

Below are the steps are taken to deploy the contacts over Ropsten Test Network:
1) Compile Gems.sol in remix and copy the ABI. 
2) Take ABI and paste the ABI (Json file) in app folder where UI code is present.
3) Deploy the Gems.sol and give initial token that will be passed in the constructor of the Gems.sol.
4) Once Gems.sol(ERC20 token) code is deployed now we have the contract address, take this address and 
use it in the code that will interact with solidity code (index.html in our case).
5) Now it is time to compile and deploy the RareGems.sol code (Marketplace code). After Compiling and 
taking the ABI use the Gems.sol files contract address and pass it in the constructor of RareGems.sol 
while deploying it.
6) Once we have the contract address of the marketplace code use it to access the functions and interact 
with the solidity code from UI.
7) Make sure you have enough ether while deploying as some gas is needed by the deployer to deploy the 
smart contract
8) Once deployment is done the next step is to import the token in our case our token is Gems. On 
successful import of token we can exchange those tokens with different users and buy-sell can take 
place using our own ERC20 token.


