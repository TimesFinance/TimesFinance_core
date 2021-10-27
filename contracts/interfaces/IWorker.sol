//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

interface IWorker {

    /// @dev 
    function openPosition(
        uint256 positionId,
        address user,
        address borrowToken,
        uint256 borrow,
        bytes calldata data
    ) external payable;

    /// @dev 
    function closePosition(
        uint256 positionId,
        address user,
        address borrowToken,
        uint256 borrow,
        bytes calldata data
    ) external payable;

    /// @dev Return the amount of ETH wei to get back if we are to liquidate the position.
    function health(uint256 id, address borrowToken)
        external
        view
        returns (uint256);

    /// @dev Liquidate the given position to token need. Send all ETH back to Bank.
    function liquidate(
        uint256 id,
        address user,
        address borrowToken
    ) external;
}
