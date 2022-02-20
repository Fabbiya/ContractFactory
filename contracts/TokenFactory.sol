// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./TokenTest.sol";
import "@optionality.io/clone-factory/contracts/CloneFactory.sol";
import '@openzeppelin/contracts/access/Ownable.sol';


contract TokenFactory is Ownable, CloneFactory {
  address public motherAddress;
  address[] _holders;
 

  event TokenCreated(address newToken);

  constructor(address _mother)  {
    motherAddress = _mother;
  }

  function setMotherAddress(address _motherAddress) public onlyOwner {
    motherAddress = _motherAddress;
  }

  function cloneToken(string calldata name_, string calldata symbol_) public onlyOwner {
    address clone = createClone(motherAddress);

    TokenTest motherToken = TokenTest(motherAddress);
    _holders = motherToken.getHolders();  
    
    TokenTest clonedToken = TokenTest(clone);
    clonedToken.init(name_, symbol_);
    
    
    for (uint256 index = 0; index < _holders.length; index++) {
      clonedToken.setHolder(_holders[index],motherToken.balanceOf(_holders[index]));
    }
    emit TokenCreated(clone);
    
  }
}
