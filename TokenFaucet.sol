// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//import Open Zepplins ERC-20 contract
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

//create a token Faucet contract that inherits Open Zepplins ERC-20 contract
contract TokenFaucet is ERC20 {

    uint private requsteAmount = 1e18;
    uint private MAX_TOKENS = 5e26;
    uint private TIME_LOCK_PERIOD = 10 minutes;

    //when deploying the token give it a name and symbol
    //specify the amount of tokens minted for the owner
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        _mint(msg.sender, MAX_TOKENS);
    }

    //when you requestTokens address and blocktime +  TIME_LOCK_PERIODis saved in Time Lock
    mapping(address => uint) private lockTime;

    //allow users to call the requestTokens function to mint tokens
    function requestTokens (address requestor) external {
        
        //perform a few check to make sure function can execute
        require(block.timestamp > lockTime[msg.sender], "lock time has not expired. Please try again later");
        
        //mint tokens
        _mint(requestor, requsteAmount);

        //updates locktime 1 day from now
        lockTime[msg.sender] = block.timestamp + TIME_LOCK_PERIOD;
    }
}
