from web3 import Web3
import json
import os
from dotenv import load_dotenv
import pprint
# from "../../../utilities/toBytesConverter.py" import 

load_dotenv()


name_1 = "13_gatekeeper"
contract_name_1 = "GatekeeperOne"

name_2 = "13_gatekeeper_attack"
contract_name_2 = "Attack"

name_3 = "TEST"
contract_name_3 = "TestContract"

# address and creds
my_address = os.getenv("MY_ADDRESS")
private_key = os.getenv("PRIVATE_KEY")


def get_variable(file_name, contract_name, *args):
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

    # print(contract.functions.entrant().call())

    # print(contract.functions.number().call())
    # storage_value =contract.functions.getProperInput().call()
    # hex_value = hex(int.from_bytes(storage_value, byteorder='big'))
    # print(hex_value)

    

    # print(contract.functions.myAddress().call())
    # print(contract.functions.callmeToGetGas().call())
    if file_name==name_1:
        pass
    elif file_name==name_2:
        print(contract.functions.getProperInput().call())
    elif file_name==name_3:
        print(contract.functions.testTest().call())
        print(contract.functions.myAddress().call())


def change_some_values(file_name,contract_name,*args):
    input = get_input(file_name,contract_name)
    abi = input[0]
    contract_address = input[1]

    # connect to contract
    w3 = Web3(Web3.HTTPProvider("HTTP://127.0.0.1:7545"))
    nonce = w3.eth.get_transaction_count(my_address)
    contract = w3.eth.contract(address=contract_address,abi=abi)

    add_transaction = "" 
    
    if file_name==name_1:
        pass
    elif file_name==name_2:
        pass
    elif file_name==name_3:
        add_transaction = contract.functions.testTest().build_transaction({ "from":my_address, "nonce":nonce})

    if add_transaction != "":
        # sign transaction
        signed_add_txn = w3.eth.account.sign_transaction(add_transaction, private_key=private_key)
        # send this signed transaction
        tx_hash = w3.eth.send_raw_transaction(signed_add_txn.rawTransaction)
        receipt = w3.eth.wait_for_transaction_receipt(tx_hash)
        print("Transaction receipt mined:")
        pprint.pprint(dict(receipt))




def get_input(file_name, contract_name):
    with open("./compiled/"+file_name+"_compiled/abi_"+contract_name+".json", "r") as file:
        abi = json.load(file)
    # contract address
    contract_address=""
    if file_name==name_1:
        contract_address = "0xE3c0C2DA6b84D003252Db8EBb5bB4383ea5B9f61"
    elif file_name==name_2:
        contract_address = "0x03A094853A57a34DBB5E76C20F0573dE8431c3eB"
    elif file_name==name_3:
        contract_address = "0x3CEEA292055c25004A5746261EEe30f38BB660AA"
    return (abi,contract_address)

def interact():
    try:
        # get_variable(name_1, contract_name_1)
        # get_variable(name_2, contract_name_2)
        # get_variable(name_3, contract_name_3)
        change_some_values(name_3, contract_name_3)
        
    except FileNotFoundError as e:
        print("FAIL: no such file")


def zBytes16(input):
    zBytes = input
    #zBytes = "YAY!! We Are Going To Make Ethereum & Python Great! Go Crypto and Blockchain and DAG, etc...!!!"
    len1 = len(zBytes)
    if len1 > 16:
        print('input string length: '+ str(len1)+ ' is too long')
        zBytes16 = zBytes[:16]
    else:
        print('input string length: '+ str(len1)+ ' is too short')
        print('More characters needed: '+ str(16-len1))
        zBytes16 = zBytes.ljust(16, '0')
    print('zBytes16 = '+ str(zBytes16)+ ' and its length: '+ str(len(zBytes16)))
    xBytes32 = bytes(zBytes16, 'utf-8')
    return zBytes


def send_ether():
    # connect to contract
    w3 = Web3(Web3.HTTPProvider("HTTP://127.0.0.1:7545"))
    tx = {
        'nonce' : w3.eth.get_transaction_count(my_address),
        'to' : "0xd631C0f607a7CACb7880B89c94121aA3990E963a",
        'value' : w3.to_wei(2, 'ether'),
        'gas' : 2000000,
        'gasPrice' :  w3.to_wei(100, 'gwei')
    }
    # sign transaction
    signed_add_txn = w3.eth.account.sign_transaction(tx, private_key=private_key)
    # transaction hash
    tx_hash_send = signed_add_txn.hash
    # send transaction
    tx_hash = w3.eth.send_raw_transaction(signed_add_txn.rawTransaction)

# interact()
# send_ether()

#  0x\x00\x00\x00\x00\x00\x00\x87\x11
#  b'\x00\x00\x00\x00\x00\x00\x00\x00'



def test(_abi, _contract_address):
    my_address = os.getenv("MY_ADDRESS")
    private_key = os.getenv("PRIVATE_KEY")

    abi = _abi # contracts abi 
    contract_address = _contract_address # contracts address

    # connect to contract
    w3 = Web3(Web3.HTTPProvider("HTTP://127.0.0.1:7545"))
    nonce = w3.eth.get_transaction_count(my_address)
    contract = w3.eth.contract(address=contract_address,abi=abi)

    print(contract.functions.testTest().call()) 
    # this gives 0x0000000000000000000000000000000000000000
    
    print(contract.functions.myAddress().call()) 
    # this gives legit contracts address e.g. 
    # 0x13997C24536d6266B871B6478e803F186F3B6ffD

def test_2(_abi, _contract_address):
    my_address = os.getenv("MY_ADDRESS")
    private_key = os.getenv("PRIVATE_KEY")

    abi = _abi # contracts abi 
    contract_address = _contract_address # contracts address

    # connect to contract
    w3 = Web3(Web3.HTTPProvider("HTTP://127.0.0.1:7545"))
    nonce = w3.eth.get_transaction_count(my_address)
    contract = w3.eth.contract(address=contract_address,abi=abi)

    add_transaction = contract.functions.testTest().build_transaction({ "from":my_address, "nonce":nonce})
    # sign transaction
    signed_add_txn = w3.eth.account.sign_transaction(add_transaction, private_key=private_key)
    # send this signed transaction
    tx_hash = w3.eth.send_raw_transaction(signed_add_txn.rawTransaction)
    receipt = w3.eth.wait_for_transaction_receipt(tx_hash)
    print("Transaction receipt mined:")
    pprint.pprint(dict(receipt))


(a, b) = get_input(name_3, contract_name_3)
test(a,b)
