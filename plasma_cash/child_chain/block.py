import rlp
from rlp.sedes import CountableList

from .transaction import Transaction


class Block(rlp.Serializable):

    fields = [('transaction_set', CountableList(Transaction))]

    def __init__(self):
        pass
