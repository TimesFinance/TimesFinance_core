//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

interface IStrategyLiquidate {
    function execute(uint256 tokenId, address borrowToken) external payable;

    function getBorrowTokenAmount(uint256 tokenId, address borrowToken)
        external
        view
        returns (uint256);

}
