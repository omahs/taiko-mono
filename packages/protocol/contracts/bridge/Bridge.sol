// SPDX-License-Identifier: MIT
//
// ╭━━━━╮╱╱╭╮╱╱╱╱╱╭╮╱╱╱╱╱╭╮
// ┃╭╮╭╮┃╱╱┃┃╱╱╱╱╱┃┃╱╱╱╱╱┃┃
// ╰╯┃┃┣┻━┳┫┃╭┳━━╮┃┃╱╱╭━━┫╰━┳━━╮
// ╱╱┃┃┃╭╮┣┫╰╯┫╭╮┃┃┃╱╭┫╭╮┃╭╮┃━━┫
// ╱╱┃┃┃╭╮┃┃╭╮┫╰╯┃┃╰━╯┃╭╮┃╰╯┣━━┃
// ╱╱╰╯╰╯╰┻┻╯╰┻━━╯╰━━━┻╯╰┻━━┻━━╯
pragma solidity ^0.8.9;

// Do we need to have our own wrapped tokens on our own chain to mint ether to users in an atomic swap?

// for Native Token Bridge we want to implement lock and mint from L1 to L2, burn and transfer from L2
// to L1.

// Interface for both L1 and L2 bridges, should have abstract functions
abstract contract Bridge {
    /* ========== Events ========== */
    event FundsDeposited(
        address indexed depositor,
        address indexed recipient,
        uint256 amount
        //  bytes32 merkleproof?
    );

    event FundsWithdrawn(
        address indexed withdrawer,
        uint256 amount
        // bytes32 merkleproof
    );

    // perhaps events for crediting and debiting like in Hop to keep track of
    //balances and such of specific accounts?

    /* ========== Functions ========== */

    // receive() function? should we store account balances on each bridge? or vault tracks based on
    // emitted data?

    function deposit(address recipient, uint256 amount) external payable {
        // credit the amount received? again similar to Hop design perhaps
        emit FundsDeposited(msg.sender, recipient, amount);
    }

    function withdraw(uint256 amount) public {
        // require(msg.sender.balance!=0)
        // should this be a common function? should we leave it as abstract and override
        // in each respective bridge?
        emit FundsWithdrawn(msg.sender, amount);
    }
}
