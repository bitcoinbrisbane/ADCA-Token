pragma solidity ^0.4.24;

import "./ERC20.sol";
import "./Ownable.sol";
import "./SafeMath.sol";

contract Token is Ownable, ERC20 {
    using SafeMath for uint;

    string public symbol = "ADCA";
    string public name = "ADCA Membership Token";
    uint8 public decimals = 0;
    uint256 public totalSupply;

    mapping (address => uint256) private balances;
    mapping (address => mapping (address => uint256)) private allowed;

    constructor() public {
    }

    function transfer(address to, uint256 value) public onlyOwner() returns (bool) {
        require(to != address(0), "Invalid address");
        require(value == 1, "Can only issue one token at a time");

        balances[to] == 1;
        totalSupply += value;

        emit Transfer(msg.sender, to, value);

        return true;
    }

    function allowance(address tokenOwner, address spender) public view returns (uint remaining) {
        return allowed[tokenOwner][spender];
    }

    function transferFrom(address from, address to, uint256 value) public onlyOwner() returns (bool success) {
        require(to != address(0), "Invalid address");

        balances[from] = balances[from].sub(value);
        allowed[from][msg.sender] = allowed[from][msg.sender].sub(value);
        balances[to] = balances[to].add(value);

        emit Transfer(from, to, value);
        return true;
    }

    function approve(address spender, uint256 value) public returns (bool) {
        require(spender != address(0), "Invalid address");

        allowed[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function () public payable {
        revert("Not payable");
    }
}