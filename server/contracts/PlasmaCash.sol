pragma solidity ^0.4.24;

import "token/ERC721/ERC721Receiver.sol";

contract PlasmaCash is ERC721Receiver {
  function onERC721Received(address _from, uint256 _uid, bytes)
    public
    returns(bytes4)
  {
    deposit(_from, uint64(_uid), uint32(1));
    return ERC721_RECEIVED;
  }

  function deposit(address from, uint64 uid, uint32 denomination) private {
    // TODO: Implement deposit
  }

  function withdraw(uint64 slot) external {
    // TODO: Make sure the coin is exited.
    // Then transfer the ERC721 token to the sender.
  }

  // Exiting
  function startExit(
    uint64 slot,
    bytes prevTxBytes, bytes exitingTxBytes,
    bytes prevTxInclusionProof, bytes exitingTxInclusionProof,
    bytes signature,
    uint256[2] blocks) {

    // This is where we should start putting the coin into a exit state.
    // The exit will be held for a certain time period, which is up to challenge.
  }

  function finalizeExit(uint64 slot) public {
    // We need to check for the specific exit slot, to make sure the coin:
    // 1. Started to exit and has not already exited
    // 2. Has responded to challenges
    // If challenge wasn't responded, we slash their bond.
    // Otherwise, it's a successfully exit, free bond and assign the coin.
  }

  // Types of challenges to submit according to https://karl.tech/plasma-cash-simple-spec/:
  // 1. Exit Spent Coin Challenge
  // 2. Exit Double Spend Challenge
  // 3. Exit With Invalid History Challenge
  function challengeExitSpentCoin() external {

  }

  function challengeDoubleSpend() external {

  }

  function challengeInvalidHistory() external {

  }

  // And each challenge allows the exiter to respond to that challenge.
  function respondToExitSpentCoinChallenge() external {

  }

  function respondToDoubleSpendChallenge() external {

  }

  function respondToInvalidHistoryChallenge() external {

  }
}
