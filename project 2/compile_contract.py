from solcx import compile_standard
import json
import os


name_1 = "first_file"
name_2 = "MySecondContract"


def compile_solidity_file(file_name):
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
    bytecode = compiled_sol["contracts"][file_name+".sol"][file_name]["evm"]["bytecode"]["object"]
    # get abi
    abi = compiled_sol["contracts"][file_name+".sol"][file_name]["abi"]

    with open("./compiled/"+file_name+"_compiled/abi.json", "w") as file:
        json.dump(abi, file)
    with open("./compiled/"+file_name+"_compiled/bytecode.json", "w") as file:
        json.dump(bytecode, file)


try:
    compile_solidity_file(name_2)
except FileNotFoundError as e:
    print("no such file")








