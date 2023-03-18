//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
 
import"./PriceConverter.sol";

 //0xa1eb38e68fC0c6578C44aE3BA1378E6a799F1cC0

contract FundMe{

    using PriceConverter for uint256;

    uint256 public minimumUsd = 50*1e18;

    address[]public funders;

    mapping(address=>uint256)public addressToAmountFunded;

    address public i_owner;

     constructor() {
        i_owner = msg.sender;
    }
    function fund() public payable {
        // msg.value;
        // msg.value.getConversionRate();

        require(msg.value.getConversionRate() >= minimumUsd,"didn't send enough ");

        funders.push(msg.sender);

        addressToAmountFunded[msg.sender] += msg.value;

    }

    function withdraw() public onlyOwner {
        // require(msg.sender == i_owner);
        for(uint256 funderIndex=0;funderIndex < funders.length;funderIndex++){

            address funder = funders[funderIndex];
            addressToAmountFunded[funder] =0;

        }
        funders = new address[](0);

       // bool sendSuccess = payable( msg.sender).transfer(address(this).balance);

       //require(sendSuccess,"Send failed");

        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");



    }


    modifier onlyOwner{
        require(msg.sender == i_owner, "Sender is not owner!");
        _;

    }

}
