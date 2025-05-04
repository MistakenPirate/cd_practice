def classify_text(text):
    state = 'q1'  # Initial state
    
    for char in text:
        if state == 'q1':  # In the middle of processing
            if char == '?':  # Question mark detected
                state = 'q2'
            elif char == '.':  # Period detected
                state = 'q3'
            else:
                state = 'q1'  # Stay in q1 for any other characters
                
        elif state == 'q2':  # After '?' (valid question)
            return "Question"  # It's a question if it ends in '?'
        
        elif state == 'q3':  # After '.' (valid statement)
            return "Statement"  # It's a statement if it ends in '.'
        
        elif state == 'q4':  # Dead state (invalid input)
            return "Invalid"  # Invalid input
        
    # Final check: text must end with either '.' or '?'
    if state == 'q2':
        return "Question"
    elif state == 'q3':
        return "Statement"
    else:
        return "Invalid"

# Test cases
test_sentences = [
    "How are you?",  # Question
    "This is a test.",  # Statement
    "This is incorrect",  # Invalid (no ending punctuation)
    "Are you there",  # Invalid (no ending punctuation)
    "Do you know this?",  # Question
    "It is raining today."  # Statement
]

for sentence in test_sentences:
    print(f"'{sentence}': {classify_text(sentence)}")