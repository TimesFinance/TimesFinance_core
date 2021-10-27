//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

interface InterestModel {
    function getInterestRate(uint256 debt, uint256 floating) external pure returns (uint256);
}