from web3 import Web3
import os
import json
from dotenv import load_dotenv

load_dotenv()


# this is a test account with fake money
my_address = os.getenv("MY_ADDRESS")
private_key = os.getenv("PRIVATE_KEY")


name_1 = "first_file"
name_2 = "MySecondContract"
name_3 = "MyThirdContract"


# create we3 provider
w3 = Web3(Web3.HTTPProvider("HTTP://127.0.0.1:7545"))


def create_contract(file_name, *args):
    with open("./compiled/"+file_name+"_compiled/abi.json", 'r') as file:
        abi = json.load(file)
    with open("./compiled/"+file_name+"_compiled/bytecode.json","r") as file:
        bytecode = json.load(file)

    # create contract
    contract = w3.eth.contract(abi=abi, bytecode=bytecode)
    # get latest trnsaction number
    nonce = w3.eth.get_transaction_count(my_address)
    # build transaction
    transaction = contract.constructor(*args).build_transaction(
        {"from":my_address, "nonce":nonce}
    )
    # sign transaction
    signed_transaction = w3.eth.account.sign_transaction(transaction, private_key=private_key)
    # send transaction 
    tran_hash =  w3.eth.send_raw_transaction(signed_transaction.rawTransaction)
    print("SUCCESS: Contract deployed.")


try:
    create_contract(name_1, "MAKE MY DAY", 11)
    # create_contract(name_2)
    # create_contract(name_3)

except FileNotFoundError as e:
    print("FAIL: no such file")
except TypeError as e:
    print("FAIL: Probably constructor needs some arguments...")
    print(e)