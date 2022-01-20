pragma solidity ^0.8.10;
// A simple Piggy Bank smart contract for Ethereum
// Written by Mo Ashouri, ashourics@gmail.com


contract PiggyBank {

    address public owner = msg.sender; //means the address of the person who deploys the contract, 
    //if you do not write Public as its modifier, by default it becomes a private variable

    // We need to add 2 evetns to inform the external users about deposit and  withdraw

    event Deposit(uint amount);
    event Withdraw(uint amount);

     //receive is a fallback type function, because it is payable it allows the function to receive Ethers
     receive() external payable {
         emit Deposit(msg.value); // we use emit to call an event explicitly, msg.value contains the amount of wei (ether / 1e18) sent in the transaction
         
     }
     
     // a customized function to withdraw from the contract, only by the owner of the contract, i.e., who deplys it
     // it is external thet means other contracts can invoke it
     function withdraw() external{

        require(msg.sendere == owner, "it is not the owner of the contract"); // check whether the person who calls the function is the real owner who deply the contract, otehrwise exit the function
        //send the Eths to the real owner and delete the piggybank contract 
        // What is selfdesctruct?
        // By calling this selfdestruct function, a smart contract can be removed from the blockchain
        // and all the Ethers on the contract will be transfered to a specified address

       emit Withdraw(address(this).balance); // we want to make the withdraw (the balance of the contract {explocitly call it with its address}) tracable to the blockchain
       
        selfdesctruct(payable(msg.sender)); // == means  withdraw the whole balance to the the owner address and then kill and delete the contract from the blockchain network


     }


}
