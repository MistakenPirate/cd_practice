grammar = {
    'E' : ['T A'],
    'A' : ['+ T A', 'e'],
    'T' : ['F B'],
    'B' : ['* F B', 'e'],
    'F' : ['( E )', 'i']
}

terminals = ['+','*','(',')','i','e','$']
non_terminals = list(grammar.keys())

first = {nt: set() for nt in grammar}
follow = {nt: set() for nt in grammar}
follow['E'].add('$')

def com_first(symbol):
    if symbol in terminals:
        return {symbol}
    
    first_set = set()

    for prod in grammar[symbol]:
        parts = prod.split()
        for part in parts:
            path_first = com_first(part)
            first_set.update(path_first - {'e'})
            if 'e' not in path_first:
                break
        else:
            first_set.add('e')

    return first_set

for nt in non_terminals:
    first[nt] = com_first(nt)

for nt in non_terminals:
    print(f"FIRST({nt}) : {sorted(first[nt])}")