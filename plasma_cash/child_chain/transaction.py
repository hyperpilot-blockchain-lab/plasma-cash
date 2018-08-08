from typing import ByteString

import ethereum.utils
import rlp
from rlp.sedes import BigEndianInt, big_endian_int, binary
from web3.auto import w3

from utils.utils import get_sender, sign

from .exceptions import InvalidTxSignatureException


class Transaction(rlp.Serializable):

    fields = [
        ('uid', big_endian_int),
        ('prev_block', big_endian_int),
        ('denomination', big_endian_int),
        ('new_owner', ethereum.utils.address),
        ('signature', big_endian_int),
    ]

    def __init__(
        self,
        uid: BigEndianInt,
        prev_block: BigEndianInt,
        denomination: BigEndianInt,
        new_owner: BigEndianInt,
        signature: ByteString = b'\x00' * 65,
    ):
        self.uid = uid
        self.prev_block = prev_block
        self.denomination = denomination
        self.new_owner = ethereum.utils.normalize_address(new_owner)
        self.signature = signature
        self.spent = False  # not part of the rlp
        self.make_mutable()

    @property
    def hash(self):
        if self.prev_block != 0:
            ret = w3.sha3(rlp.encode(self, UnsignedTransaction))
        else:
            ret = w3.soliditySha3(['uint64'], [self.uid])
        return ret

    @property
    def merkle_hash(self):
        return w3.sha3(rlp.encode(self))

    @property
    def sender(self):
        if self.signature == b'\x00' * 65:
            raise InvalidTxSignatureException('Tx not signed')
        return get_sender(self.hash, self.signature)

    def sign(self, key):
        self.signature = sign(self.hash, key)


UnsignedTransaction = Transaction.exclude(['signature'])
