pragma solidity ^0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../node_modules/@openzeppelin/contracts/utils/math/SafeMath.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";

contract Wallet {

    using SafeMath for uint256;
    struct Token {
        bytes32 ticker;
        address tokenAddress;

    }

    bytes32[] public tokenList;
    mapping(bytes32 => Token) public tokenMapping;
    mapping (address => mapping( bytes32 => uint256)) public balances;

    modifier tokenExist(bytes32 ticker) {
        require(tokenMapping[ticker].tokenAddress != address(0), "token does not exist");
        _;
    }

    function addToken(bytes32 ticker, address tokenAddress) external {
        tokenMapping[ticker] = Token(ticker, tokenAddress);
        tokenList.push(ticker);
    }

    function deposit(uint amount, bytes32 ticker) tokenExist(ticker) external {
        IERC20(tokenMapping[ticker].tokenAddress).transferFrom(msg.sender,address(this), amount);
        balances[msg.sender][ticker] = balances[msg.sender][ticker].add(amount);
    }

    function withdraw(uint amount, bytes32 ticker) external {
        require(tokenMapping[ticker].tokenAddress != address(0)) ;
        require(balances[msg.sender][ticker] >= amount, "Balance not sufficient");
        IERC20(tokenMapping[ticker].tokenAddress).transfer(msg.sender,amount);
        balances[msg.sender][ticker] = balances[msg.sender][ticker].sub(amount);
    }


}