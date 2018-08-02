pragma solidity ^0.4.24;

import "./token/ERC721/ERC721Receiver.sol";


contract PlasmaCash is ERC721Receiver {
    // Storage
    struct Exit {

    }

    mapping (uint64 => Token) tokens;
    struct Token {
        uint64 tokenId;
        address owner;
        Exit exit;
    }

    function onERC721Received(address _from, uint256 _uid, bytes)
        public
        returns(bytes4)
    {
        deposit(_from, uint64(_uid));
        return ERC721_RECEIVED;
    }

    function deposit(address from, uint64 uid) private {
        Token memory token;
        token.tokenId = uid;
        token.owner = from;
        tokens[uid] = token;
    }

    function withdraw(uint64 tokenId) external {
        Token memory token = tokens[tokenId];
        require(token.owner == msg.sender, "Invalid owner attempting to withdraw");
        // TODO: Make sure the coin is exited.
        // Then transfer the ERC721 token to the sender.
    }

    // Exiting
    function startExit(
        uint64 tokenId,
        bytes prevTxBytes, bytes exitingTxBytes,
        bytes prevTxInclusionProof, bytes exitingTxInclusionProof,
        bytes signature,
        uint256[2] blocks) {

        // This is where we should start putting the coin into a exit state.
        // The exit will be held for a certain time period, which is up to challenge.
    }

    function finalizeExit(uint64 tokenId) public {
        // We need to check for the specific exit slot, to make sure the coin:
        // 1. Started to exit and has not already exited
        // 2. Has responded to challenges
        // If challenge wasn't responded, we slash their bond.
        // Otherwise, it's a successfully exit, free bond and assign the coin.
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
}
