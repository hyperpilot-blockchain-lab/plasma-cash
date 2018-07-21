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
```
