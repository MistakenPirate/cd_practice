grammar = {
    'E': ['T A'],
    'A': ['+ T A', 'e'],
    'T': ['F B'],
    'B': ['* F B', 'e'],
    'F': ['( E )', 'i']
}

terminals = ['+','*','(',')','i','e','$']
non_terminals = list(grammar.keys())

first = {nt: set() for nt in non_terminals}
follow = {nt: set() for nt in non_terminals}
follow['E'].add('$')

def compute_first(symbol):
    if symbol in terminals:
        return {symbol} # FIRST of a terminal is itself
    if symbol == 'e':   # FIRST of epsilon is just epsilon
        return {'e'}
    
    first_set = set()

    for production in grammar[symbol]:  # For each rule like B -> ß
        parts = production.split()      # ß becomes [X1, X2, X3, ...]
        for part in parts:
            part_first = compute_first(part) # FIRST(Xi)
            first_set.update(part_first - {'e'}) # Add all EXCEPT epsilon
            if 'e' not in part_first:
                break   # Stop if FIRST(part) does not contain epsilon
        else:
            first_set.add('e')   # If all Xi can derive epsilon, add e
    return first_set

for nt in non_terminals:
    first[nt] = compute_first(nt)

for nt in non_terminals:
    print(f"FIRST({nt}) : {sorted(first[nt])}")

def com_f():
    while True:
        updated = False

        for nt in non_terminals:
            for production in grammar[nt]:
                symbols = production.split()

                trailer = follow[nt].copy()

                for symbol in reversed(symbols):
                    if symbol in non_terminals:
                        before = len(follow[symbol])
                        follow[symbol].update(trailer)
                        after = len(follow[symbol])
                        if before < after:
                            updated = True
                        
                        if 'e' in first[symbol]:
                            trailer.update(first[symbol] - {'e'})
                        else:
                            trailer = first[symbol]
                    elif symbol in terminals:
                        trailer = {symbol}
                        
        
        if not updated:
            break


def compute_follow():
    while True:
        updated = False # Track if follow set changed in this iteration
        
        for nt in non_terminals:
            for production in grammar[nt]:
                symbols = production.split()

                # Start with trailer = FOLLOW(nt) (the thing currently being defined)
                trailer = follow[nt].copy()

                # Traverse the production in reverse
                for symbol in reversed(symbols):
                    if symbol in non_terminals:

                         # Save current size to check if FOLLOW[symbol] changed later
                        before = len(follow[symbol])

                        # Add trailer to FOLLOW[symbol]
                        follow[symbol].update(trailer)

                        # Check if any new symbol was added
                        after = len(follow[symbol])
                        if after > before:
                            updated = True
                        
                        # Update trailer: if symbol can be epsilon,
                        # trailer also includes FIRST(symbol) - {e}
                        if 'e' in first[symbol]:
                            trailer.update(first[symbol] - {'e'})
                        else:
                            trailer = first[symbol].copy()

                    elif symbol in terminals:
                        # If it's a terminal, trailer is just that symbol now
                        trailer = {symbol}
                    # ε doesn't affect trailer
                
        if not updated:
            break   # Skip 'e' — epsilon doesn’t affect trailer

com_f()

print("\nFollow Sets:")
for nt in non_terminals:
    print(f"Follow({nt}) = {sorted(follow[nt])}")





