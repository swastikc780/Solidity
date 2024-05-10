// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC20 {
    string public name;
    string public symbol;
    uint8 public immutable decimals;
    uint256 public totalSupply;
    mapping(address => uint256) _balances;
    mapping(address => mapping(address => uint256)) _allowances;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    constructor(string memory _name, string memory _symbol, uint256 _totalSupply) {
        name = _name;
        symbol = _symbol;
        decimals = 18;
        totalSupply = _totalSupply;
        _balances[msg.sender] = _totalSupply;
    }

    function balanceOf(address _owner) public view returns(uint256) {
        require(_owner != address(0), "!Za");
        return _balances[_owner];
    }

    function transfer(address _to, uint256 _value) public returns(bool) {
        require((_balances[msg.sender] >= _value) && (_balances[msg.sender] > 0), "!Bal");
        _balances[msg.sender] -= _value;
        _balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns(bool) {
        require(_allowances[msg.sender][_from] >= _value, "!Alw");
        require((_balances[_from] >= _value) && (_balances[_from] > 0), "!Bal");
        _balances[_from] -= _value;
        _balances[_to] += _value;
        _allowances[msg.sender][_from] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns(bool) {
        require(_balances[msg.sender] >= _value, "!bal");
        _allowances[_spender][msg.sender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public view returns(uint256) {
        return _allowances[_spender][_owner];
    }

    function mint(address _owner, uint256 _value) public virtual {
        require(_owner != address(0), "!za");

        _beforeTokenTransfer(address(0), _owner, _value);

        totalSupply += _value;
        _balances[_owner] += _value;
        emit Transfer(address(0), _owner, _value);

        _afterTokenTransfer(address(0), _owner, _value);
    }

    function burn(address _owner, uint256 _value) public virtual {
        require(_owner != address(0), "!za");

        _beforeTokenTransfer(_owner, address(0), _value);

        uint256 _ownerBalance = _balances[_owner];
        require(_ownerBalance >= _value, "!bal");
        unchecked {
            _balances[_owner] = _ownerBalance - _value;
        }
        totalSupply -= _value;

        emit Transfer(_owner, address(0), _value);

        _afterTokenTransfer(_owner, address(0), _value);
    }
    function _beforeTokenTransfer(
        address _from,
        address _to,
        uint256 _value
    ) internal virtual {}

    function _afterTokenTransfer(
        address _from,
        address _to,
        uint256 _value
    ) internal virtual {}

}