def dfa(str):
    state = 0

    for char in str:
        if state == 0:
            state = 1 if char == '1' else 0
        
        elif state == 1:
            state = 4 if char == '1' else 2
        
        elif state == 2:
            state = 3 if char == '1' else 5
        
        elif state == 4:
            state = 5 if char == '1' else 3

    return state == 3

test_strings = ["101", "110", "1110", "00101", "111", "000", "1101", "010"]
for s in test_strings:
    result = "Accepted" if dfa(s) else "Rejected"
    print(result)
    