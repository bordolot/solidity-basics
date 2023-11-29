from web3 import Web3
import json
import os
from dotenv import load_dotenv

load_dotenv()


name_1 = "first_file"
name_2 = "MySecondContract"
name_3 = "MyThirdContract"

# address and creds
my_address = os.getenv("MY_ADDRESS")
private_key = os.getenv("PRIVATE_KEY")


def get_variable(file_name):
    input = get_input(file_name)
    abi = input[0]
    contract_address = input[1]
    # print(abi)
    # print(contract_address)

    # connect to contract
    w3 = Web3(Web3.HTTPProvider("HTTP://127.0.0.1:7545"))
    nonce = w3.eth.get_transaction_count(my_address)
    contract = w3.eth.contract(address=contract_address,abi=abi)

    #### first_file contract
    # print(contract.functions.my_number().call())
    # print(contract.functions.my_string().call())

    #### MySecondContract
    # print(contract.functions.any_number().call())
    # print(contract.functions.some_string().call())

    #### MyThirdContract
    print(contract.functions.getInfo().call())


def change_some_values(file_name):
    input = get_input(file_name)
    abi = input[0]
    contract_address = input[1]

    # connect to contract
    w3 = Web3(Web3.HTTPProvider("HTTP://127.0.0.1:7545"))
    nonce = w3.eth.get_transaction_count(my_address)
    contract = w3.eth.contract(address=contract_address,abi=abi)

    # add_transaction = contract.functions.addInfo("morning",3).build_transaction({ "from":my_address, "nonce":nonce})
    # add_transaction = contract.functions.add_number().build_transaction({ "from":my_address, "nonce":nonce})
    add_transaction = contract.functions.remove_number().build_transaction({ "from":my_address, "nonce":nonce})

    # sign transaction
    signed_add_txn = w3.eth.account.sign_transaction(add_transaction, private_key=private_key)
    # send this signed transaction
    tx_hash = w3.eth.send_raw_transaction(signed_add_txn.rawTransaction)




def get_input(file_name):
    with open("./compiled/"+file_name+"_compiled/abi.json", "r") as file:
        abi = json.load(file)
    # contract address
    contract_address=""
    if file_name=="first_file":
        contract_address = "0x63cBe9304a2F5325F9a10C56671179A3088BCa50"
    elif file_name=="MySecondContract":
        contract_address = "0xb4D92040d694076EC8601C9Aa9cFAb5586F688F6"
    elif file_name=="MyThirdContract":
        contract_address = "0xD1670DE13888745709a0252bD28e345055EfEf82" 
    return (abi,contract_address)

try:
    # get_variable(name_1)
    # change_some_values(name_2)
    # get_variable(name_2)
    get_variable(name_3)
except FileNotFoundError as e:
    print("FAIL: no such file")