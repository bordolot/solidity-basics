from web3 import Web3


unchecksummed_address = "35a37f3c44cea4f740cac422b9369e0ce34f99d7"
checksummed_address = Web3.to_checksum_address(unchecksummed_address)

print(checksummed_address)
