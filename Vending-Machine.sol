// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract VendingMachine {
    address public owner;
    mapping(address => uint) public ItemBalances;

    constructor(){
        owner = msg.sender;
        ItemBalances[address(this)] = 100;
    }

    function getVendingMachineBalance() public view returns (uint) {
        return ItemBalances[address(this)];
    }

    function restock(uint amount) public{
        require(msg.sender == owner, "only the owner can restock this machine.");
        ItemBalances[address(this)] += amount;
    }

    function purchase(uint amount) public payable{
        require(msg.value >= amount * 2 ether, "You must pay atleast 2 ether per Item");
        require(ItemBalances[address(this)]>= amount, "Not enough Items in stock to fulfill purchase request");
        ItemBalances[address(this)] -= amount;
        ItemBalances[msg.sender] += amount;
    }
}