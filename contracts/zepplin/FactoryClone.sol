// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./InitToken.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";

contract FactoryClone {
  address public motherAddress;
  address[] _holders;

    constructor()  {
        motherAddress = address(new InitToken());
    }

    function setMotherAddress(address _motherAddress) public {
     motherAddress = _motherAddress;
    }

    

    function createToken() external returns (address) {
        address clone = Clones.clone(motherAddress);

        InitToken motherToken =  InitToken(motherAddress);
        _holders = motherToken.getHolders();

        InitToken clonedToken = InitToken(clone);
        clonedToken.initialize();
        
        for (uint256 index = 0; index < _holders.length; index++) {
          clonedToken.setHolder(_holders[index],motherToken.balanceOf(_holders[index]));
        }

        return clone;
    }
}
