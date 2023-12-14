

uint256_max = 115792089237316195423570985008687907853269984665640564039457584007913129639935
# in solidity type(uint256).max ==> 2**256-2

prize = 1000000000000000

number_to_break_things = uint256_max - prize
print(number_to_break_things)
