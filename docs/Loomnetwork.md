# Plasma ERC721

## Installation Guide (Mac only)

* prerequisites
    * python 3.6
    * node js

`Strongly recommend you to use a virtual env for python`

```{shell}
git clone git@github.com:loomnetwork/plasma-erc721.git
cd plasma
env LDFLAGS="-L$(brew --prefix openssl)/lib" CFLAGS="-I$(brew --prefix openssl)/include" pip install -r requreiments.txt
cd ../server
npm install
cd ../
./integration_test.sh
```

## Code Analysis

### Folder: plasma_cache

* Spars Merkle Tree is declared in the folder `plasma_cache/utils`. Including the following methods:
    * create_default_nodes
    * create_tree
    * create_merkle_proof
    * verify

* In the `contract_bind/base` folder, an abstract class of smart contract is declared here. It is the root class / contract of Plasma Cash and ERC 721.
    * ERC 721 owns much less properties in contrast to Plasma Cash:
        * register
        * transfer
        * deposit
        * balance_of

## References (toolchain, installation, related impl)

* [vyper-erc721](https://github.com/maurelian/erc721-vyper)
* [install vyper using pyenv on Mac](https://www.codementor.io/mandarvaze/how-to-install-vyper-using-pyenv-and-virtualenv-on-macos-jz2ghksd4)
* [vyper tools / resources](https://github.com/ethereum/vyper/wiki/Vyper-tools-and-resources)
