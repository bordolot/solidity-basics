# This example shows how to deploy contract on a test blochchain

from solcx import compile_standard, install_solc
import json
from web3 import Web3
import os
from dotenv import load_dotenv

load_dotenv()

with open("../contracts/Calculator.sol", 'r') as file:
    caltulator_file = file.read()

# print("installing...")
# install_solc("0.8.0")
# print("Done\n\n")
####################
# or you can install solc once in terminal: 
# $ python
# >> from solcx import install_solc
# >> install_solc("0.8.0")
# >> extit()

compiled_sol = compile_standard(
    {
        "language":"Solidity",
        "sources": {"Calculator.sol":{"content":caltulator_file}},
        "settings":{
            "outputSelection":{
                "*" : {"*": ["abi", "metadata", "evm.bytecode","evm.sourceMap"]}
            }
        },
    },
    solc_version="0.8.0",
)

with open("compiled_code.json", "w") as file:
    json.dump(compiled_sol, file)

# get bytecode
bytecode = compiled_sol["contracts"]["Calculator.sol"]["Calculator"]["evm"]["bytecode"]["object"]
# get abi
abi = compiled_sol["contracts"]["Calculator.sol"]["Calculator"]["abi"]


# for connecting ganache
w3 = Web3(Web3.HTTPProvider("HTTP://127.0.0.1:7545"))
chain_id = "5777" # - dont know why by using this var in constructor() i got an error
# this is a test account with fake money
my_address = "0xC0d494e228a026626d038FfFCeC8F3b032D3757C"
private_key = os.getenv("PRIVATE_KEY")

# create contract in python
Calculator = w3.eth.contract(abi=abi, bytecode=bytecode)
# get latest transation
nonce = w3.eth._get_transaction_count(my_address)

# build a transaction
# transaction = Calculator.constructor().build_transaction(
#     {"chainId":chain_id, "from":my_address, "nonce":nonce}
#     )
transaction = Calculator.constructor().build_transaction(
    { "from":my_address, "nonce":nonce}
    )

# sign transaction
signed_txn = w3.eth.account.sign_transaction(transaction, private_key=private_key)
# send this signed transaction
tx_hash = w3.eth.send_raw_transaction(signed_txn.rawTransaction)
tx_receipt = w3.eth.wait_for_transaction_receipt(tx_hash)

# working with contract
calculator = w3.eth.contract(address=tx_receipt.contractAddress, abi=abi)
print(calculator.functions.retrieve())