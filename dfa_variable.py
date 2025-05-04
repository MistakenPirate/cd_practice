def is_variable(word):
    state = 'q0'

    for char in word:
        if state == 'q0':
            #first must be char or underscore
            if char.isalpha() or char == '_':
                state = 'q1' #valid
            else:
                state = 'q2' #invalid

        elif state == 'q1':
            #subsequent chars can be alphanumeric or underscore
            if char.isalpha() or char.isdigit() or char == '_':
                state = 'q1'
            else:
                state = 'q2'
        
        elif state == 'q2':
            break

    return state == 'q1'

# Test cases
test_names = [
    "my_variable",  # Valid
    "var1",         # Valid
    "_privateVar",  # Valid
    "1variable",    # Invalid
    "@variable",    # Invalid
    "var-1",        # Invalid
    "x",            # Valid
    "_",            # Valid
    "2_var",        # Invalid
    "var_name!",    # Invalid
]

for name in test_names:
    print(f"'{name}': {'Valid' if is_variable(name) else 'Invalid'}")