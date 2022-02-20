// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";

contract InitToken is ERC20Upgradeable{
    mapping(address => uint256) private balances_;
    address[] public holders;
    function initialize() initializer public {
        __ERC20_init("Test", "TST");

     }
     function getHolders() public view returns (address[] memory){
        return holders;
    }

    function setHolder(address _holder, uint256 _balance) public  {
        balances_[_holder] = _balance;
        holders.push(_holder);
    }
     function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal override virtual {
        if(from != address(0) && to != address(0)){
            balances_[to] += amount;
            balances_[from] -= amount;
        }
       
    }
}