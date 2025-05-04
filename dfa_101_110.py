def dfa_contains_101_or_110(s):
    state = 0  # Start state

    for char in s:
        if state == 0:
            if char == '1':
                state = 1
            else:
                state = 0

        elif state == 1:
            if char == '0':
                state = 2  # Could be 101
            else:
                state = 4  # Could be 110

        elif state == 2:
            if char == '1':
                return True  # 101 matched
            else:
                state = 0

        elif state == 4:
            if char == '0':
                return True  # 110 matched
            else:
                state = 4  # Stay in potential 11 sequence

    return False


test_strings = ["101", "110", "1110", "00101", "111", "000", "1101", "010"]
for s in test_strings:
    result = "Accepted" if dfa_contains_101_or_110(s) else "Rejected"
    print(result)
