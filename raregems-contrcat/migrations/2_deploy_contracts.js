const RareGems = artifacts.require("RareGems");
const Gems = artifacts.require("Gems");

module.exports = function (deployer) {
  deployer.deploy(Gems,1000000).then(function(){
    return deployer.deploy(RareGems,Gems.address);
  })


 
};