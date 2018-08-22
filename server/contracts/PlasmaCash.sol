pragma solidity ^0.4.24;

import "./token/ERC721/ERC721Receiver.sol";

contract PlasmaCash is ERC721Receiver {
    struct Exit {
        bool finalized;
    }

    enum TokenState {
        UNINITIALIZED, DEPOSITED, EXITING, CHALLENGED, FINALIZED
    }

    struct Token {
        uint64 tokenId;
        address owner;
        Exit exit;
        TokenState state;
    }

    // Three types of challenges to check for according to https://karl.tech/plasma-cash-simple-spec/:
    // 1. Exit Spent Coin Challenge
    // 2. Exit Double Spend Challenge
    // 3. Exit With Invalid History Challenge
    //
    // The first two are checked at the challenge call, and the last allows the exiter to respond to
    // challenge.

    // This is called by the challenger that it can prove there is a tx after the exit tx.
    function challengeSpentCoinExit() external {

    }

    // This is called by the challenger that it can prove there is a tx between
    // the submitted tx by the exiter.
    function challengeDoubleSpendExit() external {

    }

    // This is called by the challenger that it only finds latest tx is different
    // from what the exiter txs.
    function challengeInvalidHistoryExit() external {

    }

    // The exiter needs to respond to a invalid history challenge, proving that there is
    // a valid tx after what the challenger proposed.
    function respondToInvalidHistoryChallenge() external {

    }

    function withdraw(uint64 tokenId) external {
        Token memory token = tokens[tokenId];
        require(token.owner == msg.sender, "Invalid owner attempting to withdraw");
        require(token.state == TokenState.FINALIZED, "Token is not yet finalized");
        // TOOD: Transfer the ERC721 token to the sender
    }

    // Storage
    // Tokens hold all the ERC271 tokens that are deposited to this chain
    mapping (uint64 => Token) tokens;
    // ChildChain holds each block and the submitted transaction root from the validator
    mapping (uint256 => bytes32) childChain;
    uint currentBlockNumber;

    function onERC721Received(address _from, uint256 _uid, bytes)
        public
        returns(bytes4)
    {
        deposit(_from, uint64(_uid));
        return ERC721_RECEIVED;
    }

    function submitBlock(bytes32 transactionRoot, uint256 blockNumber) public {
        require(blockNumber == currentBlockNumber + 1, "Error: not submitting new block");
        childChain[blockNumber] = transactionRoot;
        currentBlockNumber += 1;
    }

    function finalizeExit(uint64 tokenId) public {
        // We need to check for the specific exit slot, to make sure the coin:
        // 1. Started to exit and has not already exited
        // 2. Has responded to challenges
        // If challenge wasn't responded, we slash their bond.
        // Otherwise, it's a successfully exit, free bond and assign the coin.
    }

    // Exiting
    function startExit(
        uint64 tokenId,
        bytes prevTxBytes, bytes exitingTxBytes,
        bytes prevTxInclusionProof, bytes exitingTxInclusionProof,
        bytes signature,
        uint256[2] blocks) public {
        Token memory token = tokens[tokenId];
        require(token.owner == msg.sender, "Invalid owner attempting to start exit");
        require(token.state == TokenState.DEPOSITED, "Token is not in deposit state");
        // This is where we should start putting the coin into a exit state.
        // The exit will be held for a certain time period, which is up to challenge.
        token.state = TokenState.EXITING;
    }

    function deposit(address from, uint64 uid) public {
        Token memory token;
        token.tokenId = uid;
        token.owner = from;
        token.state = TokenState.DEPOSITED;
        tokens[uid] = token;
    }
}
