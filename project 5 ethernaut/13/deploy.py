from web3 import Web3
import os
import json
from dotenv import load_dotenv

load_dotenv()


# this is a test account with fake money
my_address = os.getenv("MY_ADDRESS")
private_key = os.getenv("PRIVATE_KEY")


name_1 = "13_gatekeeper"
contract_name_1 = "GatekeeperOne"
name_2 = "13_gatekeeper_attack"
contract_name_2 = "Attack"
name_3 = "00_test"
contract_name_3 = "TestContract"

# create we3 provider
w3 = Web3(Web3.HTTPProvider("HTTP://127.0.0.1:7545"))


def create_contract(file_name,contract_name, *args):
    with open("./compiled/"+file_name+"_compiled/abi_"+contract_name+".json", 'r') as file:
        abi = json.load(file)
    with open("./compiled/"+file_name+"_compiled/bytecode_"+contract_name+".json","r") as file:
        bytecode = json.load(file)

    # create contract
    contract = w3.eth.contract(abi=abi, bytecode=bytecode)
    # get latest trnsaction number
    nonce = w3.eth.get_transaction_count(my_address)
    # build transaction
    print(*args)
    transaction = contract.constructor(*args).build_transaction(
        {"from":my_address, "nonce":nonce}
    )
    # sign transaction
    signed_transaction = w3.eth.account.sign_transaction(transaction, private_key=private_key)
    # send transaction 
    tran_hash =  w3.eth.send_raw_transaction(signed_transaction.rawTransaction)
    print("SUCCESS: Contract deployed.")

def deploy(file_name, contract_name, *args):
    try:
        # create_contract(file_name,contract_name)
        create_contract(file_name,contract_name,*args)
        # create_contract(file_name,contract_name, Web3.to_bytes(text="password").ljust(32, b'\0'))

    except FileNotFoundError as e:
        print("FAIL: no such file")
    except TypeError as e:
        print("FAIL: Probably constructor needs some arguments...")
        print(e)


def to_bytes32(input):
    zBytes = input
    #zBytes = "YAY!! We Are Going To Make Ethereum & Python Great! Go Crypto and Blockchain and DAG, etc...!!!"
    len1 = len(zBytes)
    if len1 > 32:
        print('input string length: '+ str(len1)+ ' is too long')
        zBytes32 = zBytes[:32]
    else:
        print('input string length: '+ str(len1)+ ' is too short')
        print('More characters needed: '+ str(32-len1))
        zBytes32 = zBytes.ljust(32, '0')
    print('zBytes32 = '+ str(zBytes32)+ ' and its length: '+ str(len(zBytes32)))
    xBytes32 = bytes(zBytes32, 'utf-8')
    return zBytes


# print(b"password".hex())

# deploy(name_1,contract_name_1)
# deploy(name_2,contract_name_2,"0xE3c0C2DA6b84D003252Db8EBb5bB4383ea5B9f61")
deploy(name_3,contract_name_3)