pragma solidity ^0.8.0;
import "./wallet.sol";
contract Dex is Wallet {

    enum Side {
        BUY,
        SELL
    }
    
    struct Order {
        uint id;
        address trader;
        Side side;
        bytes32 ticker;
        uint amount;
        uint price;
    }

    mapping(bytes32 => mapping(uint => Order[])) public orderBook;

}