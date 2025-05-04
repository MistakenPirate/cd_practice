def dfa_last_a(s):
    state = 'q0'

    for char in s:
        if state == 'q0':
            if char == 'a':
                state = 'q1'
            elif char == 'b':
                state = 'q0'

        elif state == 'q1':
            if char == 'a':
                state = 'q1'
            elif char == 'b':
                state = 'q0'

    return state == 'q1'

test_strings = ["baa", "bab", "a", "bbaba", ""]
for s in test_strings:
    result = "Accepted" if dfa_last_a(s) else "Rejected"
    print(f"'{s}': {result}")
