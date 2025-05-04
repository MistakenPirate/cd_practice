def keyword_dfa(word):
    state = 'q0'
    transition = {
        'q0' : { 'i' : 'q1', 'e' : 'q2', 'w' : 'q3', 'r' : 'q4'},
        'q1' : { 'f' : 'ACCEPT_IF'},
        'q2' : { 'l' : 'q2a'},
        'q2a' : {'s' : 'q2b'},
        'q2b' : {'e' : 'ACCEPT_ELSE'},
        'q3' : {'h' : 'q3a'},
        'q3a' : {'i' : 'q3b'},
        'q3b' : {'l' : 'q3c'},
        'q3c' : {'e' : 'ACCEPT_WHILE'},
        'q4' : {'e' : 'q4a'},
        'q4a' : {'t' : 'q4b'},
        'q4b' : {'u' : 'q4c'},
        'q4c' : {'r' : 'q4d'},
        'q4d' : {'n' : 'ACCEPT_RETURN'}
    }
    accepting_states = {'ACCEPT_IF','ACCEPT_ELSE','ACCEPT_WHILE','ACCEPT_RETURN'}

    for char in word:
        if state in transition and char in transition[state]:
            state = transition[state][char]
        else:
            return False
        
    return state in accepting_states
    
keywords = ["if", "else", "while", "return"]
non_keywords = ["iff", "els", "whale", "ret", "for"]

print("Accepted Keywords:")
for word in keywords:
    print(f"{word}: {keyword_dfa(word)}")

print("\nRejected Non-Keywords:")
for word in non_keywords:
    print(f"{word}: {keyword_dfa(word)}")
