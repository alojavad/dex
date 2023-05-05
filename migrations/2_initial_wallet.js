const wallet = artifacts.require("wallet");

module.exports = function(deployer){
    deployer.deploy(wallet);
};