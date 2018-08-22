from time import sleep

from client.client import Client
from dependency_config import container
from utils.utils import increaseTime

alice = Client(container.get_root('alice'), container.get_token('alice'))
bob = Client(container.get_root('bob'), container.get_token('bob'))

# Operator
authority = Client(
    container.get_root('authority'), container.get_token('authority')
)
w3 = alice.root_chain.w3  # get w3 instance

# Give alice 5 tokens
alice.register()

aliceTokensStart = alice.token_contract.balance_of()
print('Alice has {} tokens'.format(aliceTokensStart))
assert aliceTokensStart == 5, "START: Alice has incorrect number of tokens"
bobTokensStart = bob.token_contract.balance_of()
print('Bob has {} tokens'.format(bobTokensStart))
assert bobTokensStart == 0, "START: Bob has incorrect number of tokens"

# Alice deposits 3 of her coins to the plasma contract and gets 3 plasma nft
# utxos in return
tokenId = 1
tx_hash, gas_used = alice.deposit(tokenId)
event_data = alice.root_chain.get_event_data('Deposit', tx_hash)
print('ALICE EVENT DATA1', event_data[0]['args'])

# Check that all deposits have registered
sleep(2)
registered_deposits = alice.get_all_deposits()
assert len(registered_deposits) == 3, "Alice has incorrect number of deposits"

# Alice to Bob transaction
alice_to_bob = alice.send_transaction(
    deposit3_utxo, deposit3_block_number, bob.token_contract.account.address
)

# Why Submit block? And what does the block number mean in this case? What does this has to do with Alice or Bob?
plasma_block1 = authority.submit_block()
