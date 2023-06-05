// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VirtualAccountService {
    address public owner;
    mapping (address => uint256) depositlist;

    event Deposit(address indexed sender, uint256 value);
    event Withdraw(address indexed owner, uint256 value);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can access this function");
        _;
    }

    constructor () {
        owner = msg.sender;
    }

    function deposit() public payable {
        depositlist[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function getdepositHistory() public view returns (uint256) {
        return depositlist[msg.sender];
    }

    function withdraw() onlyOwner public {
        address payable receiver = payable(owner);
        uint256 value = address(this).balance;
        receiver.transfer(value);
        emit Withdraw(receiver, value);
    }

}