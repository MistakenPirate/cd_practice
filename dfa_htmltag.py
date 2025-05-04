def is_valid(tag):
    state = 'q0'
    for char in tag:
        if state == 'q0':
            if char == '<':
                state = 'q1'
            else:
                state = 'q4' #invalid if it doesn't 
            
        elif state == 'q1':
            if char.isalpha():
                state = 'q2'
            else:
                state = 'q4'
        
        elif state == 'q2':
            if char.isalpha():
                state = 'q2'
            elif char == '>':
                state = 'q3'
            else:
                state = 'q4'
        
        elif state == 'q3':  # If we reach this state, the tag is valid
                return True
        
        elif state == 'q4':  # Dead state for invalid tags
            break

    return state == 'q3'  # Valid if we ended in the accepting state
        

# Test cases
test_tags = [
    "<html>",     # Valid
    "<body>",     # Valid
    "<123>",      # Invalid (starts with a number)
    "<div1>",     # Invalid (starts with a number)
    "<_tag>",     # Valid (underscore is allowed)
    "<tag!>",     # Invalid (special character not allowed)
    "<div>",      # Valid
    "<a>",        # Valid
    "<body_tag>", # Invalid (underscore is not allowed in tag names)
    "<@tag>",     # Invalid (special character not allowed)
]

for tag in test_tags:
    print(f"'{tag}': {'Valid' if is_valid(tag) else 'Invalid'}")
