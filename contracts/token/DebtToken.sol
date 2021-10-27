//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract DebtToken is ERC20Burnable, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    // bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");

    modifier onlyGovernor() {
        require(
            hasRole(DEFAULT_ADMIN_ROLE, msg.sender),
            "DebtToken: Caller is not the governor"
        );
        _;
    }
    modifier onlyMinter() {
        require(
            hasRole(MINTER_ROLE, msg.sender),
            "DebtToken: Caller is not the minter"
        );
        _;
    }
    // modifier onlyBurner() {
    //     require(
    //         hasRole(BURNER_ROLE, msg.sender),
    //         "DebtToken: Caller is not the burner"
    //     );
    //     _;
    // }

    constructor(string memory name_, string memory symbol_) ERC20(name_, symbol_) {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function grantMinter(address minter) public onlyGovernor {
        _setupRole(MINTER_ROLE, minter);
    }

    function revokeMinter(address minter) public onlyGovernor {
        revokeRole(MINTER_ROLE, minter);
    }

    function mint(address account, uint256 amount) public onlyMinter {
        _mint(account, amount);
    }

    function grantBurner(address burner) public onlyGovernor {
        _setupRole(BURNER_ROLE, burner);
    }

    function revokeBurner(address burner) public onlyGovernor {
        revokeRole(BURNER_ROLE, burner);
    }

    function burnFrom(address from, uint256 amount) public override onlyBurner {
        _burn(from, amount);
    }
}
