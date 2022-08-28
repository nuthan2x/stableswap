//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.16;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/token/ERC20/IERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/token/ERC20/ERC20.sol";

contract STABLESWAP{

    IERC20 public token1;
    address public owner1;

    IERC20 public token2;
    address public owner2;
    uint public amount;

    constructor(address _token1,address _token2,address _owner1,address _owner2){
        token1 = IERC20(_token1);
        token2 = IERC20(_token2);
        owner1= _owner1;
        owner2= _owner2;
    } 

    function approval(uint _amount) public {
        require(owner1.balance >= _amount && owner2.balance >= _amount);
        token1.approve(owner2,_amount);
        token2.approve(owner1,_amount);
        amount =_amount;
    }

    function SWAP() public{
        require(msg.sender == owner1 || msg.sender == owner2);
        safetransfer();
    }

    function safetransfer() private {
        require(token1.allowance(owner1,owner2) >= amount && token2.allowance(owner2,owner1) >= amount );

        token1.transferFrom(owner1,owner2,amount);
        token2.transferFrom(owner2,owner1,amount);
    }
}
