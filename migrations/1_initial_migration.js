const migration = artifacts.require("Migrations");

module.exports = function(deployer){
    deployer.deploy(migration);
};