def dfa_if(str):
    state = 0

    for char in str:
        if state == 0:
            state = 1 if char == 'i' else 3
        elif state == 1:
            state = 2 if char == 'f' else 3
        else:
            return False

    return state == 2

def dfa_else(str):
    state = 0

    for char in str:
        if state == 0:
            state = 1 if char == 'e' else 5
        elif state == 1:
            state = 2 if char == 'l' else 5
        elif state == 2:
            state = 3 if char == 's' else 5
        elif state == 3:
            state = 4 if char == 'e' else 5
        else:
            return False

    return state == 4

keywords = ["if", "elsea", "while", "return"]

for word in keywords:
    print(f"{word}: {dfa_if(word) or dfa_else(word)}")