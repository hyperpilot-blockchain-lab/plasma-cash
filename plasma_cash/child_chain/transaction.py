from typing import ByteString

import rlp
from ethereum import utils
from rlp.sedes import BigEndianInt, big_endian_int, binary


class Transaction(rlp.Serializable):

    fields = [
        ('uid', big_endian_int),
        ('prev_block', big_endian_int),
        ('denomination', big_endian_int),
        ('new_owner', utils.address),
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
        pass
