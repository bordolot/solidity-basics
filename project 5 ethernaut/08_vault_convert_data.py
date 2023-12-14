
value = "0x412076657279207374726f6e67207365637265742070617373776f7264203a29"

def read_storage(storage_value):

    # hex_value = hex(int.from_bytes(storage_value, byteorder='big'))
    # print(hex_value)
    hex_value = storage_value
    if hex_value.startswith('0x'):
        hex_value = hex_value[2:]
    bytes_object = bytes.fromhex(hex_value)
    result_string = bytes_object.decode('utf-8')
    # result_string = bytes.fromhex(result_string).decode('utf-8')
    print(result_string)

    # print(contract.functions.my_string().call())


# read_storage(value)
#4cb6584c59f056503de3735dd382fec5ec818f493e9fd4c8e41ae251c50dba89

