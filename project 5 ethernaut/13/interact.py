from web3 import Web3
import json
import os
from dotenv import load_dotenv

load_dotenv()


name_1 = "13_gatekeeper"
contract_name_1 = "GatekeeperOne"

name_2 = "13_gatekeeper_attack"
contract_name_2 = "Attack"


# address and creds
my_address = os.getenv("MY_ADDRESS")
private_key = os.getenv("PRIVATE_KEY")


def get_variable(file_name, contract_name):
    input = get_input(file_name, contract_name)
    abi = input[0]
    contract_address = input[1]
    # print(abi)
    # print(contract_address)

    # connect to contract
    w3 = Web3(Web3.HTTPProvider("HTTP://127.0.0.1:7545"))
    nonce = w3.eth.get_transaction_count(my_address)
    contract = w3.eth.contract(address=contract_address,abi=abi)

    #### vuln_access_private_data_1 contract
    # print(contract.functions.smallNum().call())

    # storage_value = w3.eth.get_storage_at(contract_address, 2)
    # hex_value = hex(int.from_bytes(storage_value, byteorder='big'))
    # print(hex_value)
    # if hex_value.startswith('0x'):
    #     hex_value = hex_value[2:]
    # bytes_object = bytes.fromhex(hex_value)
    # result_string = bytes_object.decode('utf-8')

    # result_string = bytes.fromhex(result_string).decode('utf-8')
    # print(result_string)

    print(contract.functions.number().call())



def change_some_values(file_name,contract_name):
    input = get_input(file_name,contract_name)
    abi = input[0]
    contract_address = input[1]

    # connect to contract
    w3 = Web3(Web3.HTTPProvider("HTTP://127.0.0.1:7545"))
    nonce = w3.eth.get_transaction_count(my_address)
    contract = w3.eth.contract(address=contract_address,abi=abi)

    add_transaction = contract.functions.callme().build_transaction({ "from":my_address, "nonce":nonce})
    # add_transaction = contract.functions.add_number().build_transaction({ "from":my_address, "nonce":nonce})
    # add_transaction = contract.functions.remove_number().build_transaction({ "from":my_address, "nonce":nonce})

    # sign transaction
    signed_add_txn = w3.eth.account.sign_transaction(add_transaction, private_key=private_key)
    # send this signed transaction
    tx_hash = w3.eth.send_raw_transaction(signed_add_txn.rawTransaction)




def get_input(file_name, contract_name):
    with open("./compiled/"+file_name+"_compiled/abi_"+contract_name+".json", "r") as file:
        abi = json.load(file)
    # contract address
    contract_address=""
    if file_name==name_1:
        contract_address = "0x426E04785cd626C6889bf5E6e37cdCf2DCa6e2F5"
    elif file_name==name_2:
        contract_address = "0xC14DA61F650aD60e2DEa35cFc295082F0a5C39E5"
    elif file_name=="MyThirdContract":
        contract_address = "0xD1670DE13888745709a0252bD28e345055EfEf82" 
    return (abi,contract_address)


def interact():
    try:
        # get_variable(name_1, contract_name_1)
        get_variable(name_2, contract_name_2)
        # change_some_values(name_2, contract_name_2)
        # get_variable(name_2)
        # get_variable(name_3)
    except FileNotFoundError as e:
        print("FAIL: no such file")


interact()