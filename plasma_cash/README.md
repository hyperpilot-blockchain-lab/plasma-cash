# Plasma Cash

Inspired by [loomnetwork/plasma-erc721] and [omisego/plasma-cash].

## Directories

client:
    Code in this folder provides methods to interact with the child chain.

child_chain:
    The implementation of child chain is placed in this folder.

## TODO

* [X] Deploy contracts on ganache.
* [ ] Use web3 and py-solc to build unit testing environment.


## Development

Using monkeypatched web3.py 4.2.1 version for ganache issues
https://github.com/jordanjambazov/web3.py/commit/a61b382dd5c11de1102779868d377408c7590839 Also https://github.com/ethereum/web3.py/pull/827

Signing