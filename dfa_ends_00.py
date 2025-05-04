def dfa_ends_with_00(s):
    state = 'q0'

    for char in s:
        if state == 'q0':
            if char == '0':
                state = 'q1'
            else:
                state = 'q0'

        elif state == 'q1':
            if char == '0':
                state = 'q2'
            else:
                state = 'q0'

        elif state == 'q2':
            if char == '0':
                state = 'q2'
            else:
                state = 'q0'

    return state == 'q2'  # Accept only if it ends in '00'

test_strings = ["00", "100", "1100", "01", "000", "1", "", "101"]
for s in test_strings:
    result = "Accepted" if dfa_ends_with_00(s) else "Rejected"
    print(f"'{s}': {result}")
