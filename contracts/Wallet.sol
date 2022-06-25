pragma solidity ^0.8.0;

contract Wallet
{
    uint balance;
    event WithdrawalEvent(address _dest, uint _amount);
    event DepositEvent(uint _amount);


    function withdrawal(address _dest, uint _amount) public returns(bool)
    {
        require(_amount <= address(this).balance, "Vous n'avez pas les fonds.");
        
        (bool success, ) = _dest.call{value: _amount}("");
        if (!success){
            return false;
        }
        
        emit WithdrawalEvent(_dest, _amount);
        return true;
    }

    function getBalance() external view returns(uint)
    {
        return address(this).balance;
    }
    
    receive() payable external
    {
        emit DepositEvent(msg.value);
    }

    fallback() payable external
    {
        emit DepositEvent(msg.value);
    }
}