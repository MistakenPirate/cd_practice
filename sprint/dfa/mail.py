def is_valid(email):
    state = 'q0'
    for char in email:
        if state == 'q0':
            if char.isalnum() or char == '_':
                state = 'q1'
            else:
                return False

        elif state == 'q1':
            if char.isalnum() or char == '_':
                state = 'q1'
            elif char == '.':
                state = 'q1' 
            elif char == '@':
                state = 'q3'
            else:
                return False

        elif state == 'q3':
            if char.isalnum():
                state = 'q3'
            elif char == '.':
                state = 'q4'
            else:
                return False

        elif state == 'q4':
            if char.isalnum():
                state = 'q3'
            else:
                return False

    # Final valid states: must end in q3 (i.e., domain ended properly)
    return state == 'q3'


test_emails = [
    "user@example.com",    # Valid
    "user@com.xyz",        # Invalid
    "@example.com",        # Invalid (Starts with @)
    "user@.com",           # Invalid (Domain starts with dot)
    "user@com.",           # Invalid (Domain ends with dot)
    "user@com@com.com",    # Invalid (Too many @ symbols)
    "user.name@sub.domain.com",  # Valid
    "user@domain.com",     # Valid
    "user@domain.c",       # Invalid (TLD too short)
    "user@domain..com",    # Invalid (Consecutive dots)
    "user@domain_123.com"  # Valid
]

for email in test_emails:
    print(f"'{email}': {'Valid' if is_valid(email) else 'Invalid'}")