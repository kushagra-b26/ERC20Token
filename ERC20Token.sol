//SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.6.0;

// abstract Contract

interface IERC20 {
    function totalsupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns(bool);

    event Transfer(address indexed from, address indexed to, uint tokens);

}

//contract Mytoken is inheriting the functionalities of IERC20

contract MyToken is IERC20 {
    string public constant name = "MyToken";
    string public constant symbol = "MYT";
    uint8 public constant decimals =  0;
    address admin;

mapping(address => uint256)balances;

mapping(address => mapping(address => uint256))allowed;

uint256 totalsupply_ = 1000 wei;

//event occurred when transfer is done by someone on my behalf

event approval(address indexed tokenOwner, address indexed spender, uint tokens);
event Transfer(address indexed from, address indexed to, uint tokens);

constructor() public{
    balances[msg.sender] = totalsupply_;
    admin = msg.sender;
}

// function returns me the totalsupply of the contract

function totalsupply() public override view returns(uint256){
return totalsupply_;
}

// To check the balance of tokenOwner

function balanceOf(address tokenOwner) public override view returns(uint256){
 return balances[tokenOwner];
}

//Transfer function provides the functionality to the smart contract to transfer tokens

function transfer(address receiver, uint numTokens) public override returns(bool){
    require(numTokens <= balances[msg.sender]);
    balances[msg.sender] -= numTokens;
    balances[receiver] += numTokens;
    emit Transfer(msg.sender, receiver, numTokens);
    return true;
}

// This function helps to mint the tokens if needed and only run by the msg.sender.

function mint(uint256 _qty) public returns(uint256){
require(msg.sender == admin);
 totalsupply_ += _qty;
 balances[msg.sender] += _qty;

 return totalsupply_;
}
 
// This function burns or reduces the supply of tokens if needed.

function burn(uint256 _qty) public returns(uint256){
 require(msg.sender == admin);
 totalsupply_ -= _qty;
 balances[msg.sender] -= _qty;

 return totalsupply_;

}

// Allowance has been set to spend tokens on msg.sender's behalf from his wallet

function allowance(address _owner, address _spender) public view returns(uint256 remaining){
    return allowed[_owner][_spender];
}

// approval is given to him.

function approve(address _spender, uint256 _value) public returns (bool success) {
    allowed[msg.sender][_spender] = _value;
    emit approval(msg.sender, _spender, _value); 
    return true;
}

//function allowed someone to make use of certain amount of tokens on owner's behalf.

function transferfrom(address _from, address _to, uint256 _value) public returns(bool success){
    uint256 allowance1 = allowed[_from][msg.sender];
    require(balances[_from] >= _value && allowance1 >= _value);
    balances[_to] += _value;
    balances[_from] -= _value;
    
    emit Transfer(_from, _to, _value); 
    return true;
 }
}









