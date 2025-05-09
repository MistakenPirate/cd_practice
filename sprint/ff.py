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

def comf():
    while True:
        updated = False
        for nt in non_terminals:
            for prod in grammar[nt]:
                symbols = prod.split()
                trailer = follow[nt].copy()

                for symbol in reversed(symbols):
                    if symbol in terminals:
                        trailer = {symbol}
                    else:
                        prev = len(follow[symbol])
                        follow[symbol].update(trailer)
                        now = len(follow[symbol])

                        if now > prev:
                            updated = True

                        if 'e' in first[symbol]:
                            trailer.update(follow[symbol] - {'e'})
                        else:
                            trailer = follow[symbol].copy()

        if not updated:
            break


                



def com_follow():
    while True:
        updated = False

        for nt in non_terminals:
            for prod in grammar[nt]:
                symbols = prod.split()

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
                            trailer = first[symbol].copy()

                    elif symbol in terminals:
                        trailer = {symbol}

        if not updated:
            break

com_follow()

for nt in non_terminals:
    print(f"FOLLOW({nt}) : {sorted(follow[nt])}")
