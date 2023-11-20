from web3 import Web3
import json
import os
from dotenv import load_dotenv

load_dotenv()
# this is a test account with fake money
my_address = "0xC0d494e228a026626d038FfFCeC8F3b032D3757C"
private_key = os.getenv("PRIVATE_KEY")

contract_address = "0xd84f24F5D73d6F8E214E2c16a6dbdDE98a136541"

with open('./abi.json', 'r') as file:
    abi = json.load(file)


# working with contract
w3 = Web3(Web3.HTTPProvider("HTTP://127.0.0.1:7545"))
nonce = w3.eth._get_transaction_count(my_address)
calculator = w3.eth.contract(address=contract_address, abi=abi)

print(calculator.functions.get().call())



def call_add_in_calculator_contract(value:int):
    add_transaction = calculator.functions.add(value).build_transaction(
    { "from":my_address, "nonce":nonce}
    )
    # sign transaction
    signed_add_txn = w3.eth.account.sign_transaction(add_transaction, private_key=private_key)
    # send this signed transaction
    tx_hash = w3.eth.send_raw_transaction(signed_add_txn.rawTransaction)
    tx_receipt = w3.eth.wait_for_transaction_receipt(tx_hash)

print(calculator.functions.get().call())
