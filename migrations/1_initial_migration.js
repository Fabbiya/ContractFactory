
//const TokenTest = artifacts.require("TokenTest");
const TokenFactory = artifacts.require("TokenFactory");

module.exports = function (deployer) {
  //deployer.deploy(TokenTest);
  
  deployer.deploy(TokenFactory,"0x3349B188cbe7100F1F34137449b4b28c50ec1f0B");
};


