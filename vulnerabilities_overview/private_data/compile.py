from solcx import compile_standard
import json
import os


name_1 = "vuln_access_private_data_1"
name_2 = "vuln_test"


def compile_solidity_file(file_name, contract_name):
    with open("./"+file_name+".sol", 'r') as file:
        solidity_file = file.read()
    
    compiled_sol = compile_standard(
    {
        "language":"Solidity",
        "sources": {file_name+".sol":{"content":solidity_file}},
        "settings":{
            "outputSelection":{
                "*" : {"*": ["abi", "metadata", "evm.bytecode","evm.sourceMap"]}
            }
        },
    },
    solc_version="0.8.13",
    )

    if not os.path.exists("./compiled/"+file_name+"_compiled"):
        os.makedirs("./compiled/"+file_name+"_compiled")

    with open("./compiled/"+file_name+"_compiled/compiled_code.json", "w") as file:
        json.dump(compiled_sol, file)

    # get bytecode
    bytecode = compiled_sol["contracts"][file_name+".sol"][contract_name]["evm"]["bytecode"]["object"]
    # get abi
    abi = compiled_sol["contracts"][file_name+".sol"][contract_name]["abi"]

    with open("./compiled/"+file_name+"_compiled/abi_"+contract_name+".json", "w") as file:
        json.dump(abi, file)
    with open("./compiled/"+file_name+"_compiled/bytecode_"+contract_name+".json", "w") as file:
        json.dump(bytecode, file)


def compile(file_name,contract_name):
    try:
        compile_solidity_file(file_name,contract_name)
    except FileNotFoundError as e:
        print("no such file")


compile(name_1,"Vault")