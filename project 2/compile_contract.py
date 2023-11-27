from solcx import compile_standard
import json

with open("./first_file.sol", 'r') as file:
    solidity_file = file.read()

compiled_sol = compile_standard(
    {
        "language":"Solidity",
        "sources": {"first_file.sol":{"content":solidity_file}},
        "settings":{
            "outputSelection":{
                "*" : {"*": ["abi", "metadata", "evm.bytecode","evm.sourceMap"]}
            }
        },
    },
    solc_version="0.8.13",
)

with open("./compiled/compiled_code.json", "w") as file:
    json.dump(compiled_sol, file)

# get bytecode
bytecode = compiled_sol["contracts"]["first_file.sol"]["MyFirstContract"]["evm"]["bytecode"]["object"]
# get abi
abi = compiled_sol["contracts"]["first_file.sol"]["MyFirstContract"]["abi"]

with open("./compiled/abi.json", "w") as file:
    json.dump(abi, file)