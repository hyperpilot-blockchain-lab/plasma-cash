# import Block from ./block

from web3.contract import Contract


class ChildChain(object):

    def __init__(self, root_chain: Contract):
        # TODO use more mature db to store the blocks
        self.root_chain = root_chain
        # self.authority = authority
        # self.db = db
        # self.current_block = Block()
        # self.current_block_number = self.db.get_current_block_num()

        # Register a filter for deposit event
        # deposit_filter = self.root_chain.eventFilter('Deposit', {'fromBlock': 0})
        # worker = Thread(target=self.log_loop, args=(deposit_filter, 0.1), daemon=True)
        # worker.start()
