//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "./InterestModel.sol";

contract TripleSlopeModel is InterestModel {

    function getInterestRate(uint256 debt, uint256 floating) override external pure returns (uint256){
        uint256 utilization = floating == 0? 0: debt* 10000 / floating;

        if (utilization < 8000) {
            // Less than 80% utilization - 0%-10% APY
            return (utilization * 10e16 / 8000 / 365 days);
            
        } else if (utilization < 9000) {
            // Between 80% and 90% - 10% APY
            return (uint256(10e16) / 365 days);
            
        } else if (utilization < 10000) {
            // Between 90% and 100% - 10%-60% APY
            return ((10e16 + (utilization - 9000) * 50e16 / 1000) / 365 days);

        } else {
            // Not possible, but just in case - 50% APY
            return (uint256(50e16) / 365 days);
        }
    }
}