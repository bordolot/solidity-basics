from web3 import Web3
import json
import os
from dotenv import load_dotenv

load_dotenv()


name_1 = "first_file"
name_2 = "MySecondContract"

# address and creds
my_address = "0x69C865CDe579017Aa01B45B134678199a070c18f"
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

    print(contract.functions.my_number().call())
    print(contract.functions.my_string().call())




def get_input(file_name):
    with open("./compiled/"+file_name+"_compiled/abi.json", "r") as file:
        abi = json.load(file)
    # contract address
    contract_address=""
    if file_name=="first_file":
        contract_address = "0x63cBe9304a2F5325F9a10C56671179A3088BCa50"
    elif file_name=="MySecondContract":
        contract_address = "0xe92299e7C59Da647A80cb7a8597Fd3461F5C2F05"
    return (abi,contract_address)

try:
    get_variable(name_1)
except FileNotFoundError as e:
    print("FAIL: no such file")