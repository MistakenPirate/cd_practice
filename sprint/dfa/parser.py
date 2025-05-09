class Parser:
    def __init__(self, tokens):
        self.tokens = tokens
        self.index = 0

    def current_token(self):
        if self.index < len(self.tokens):
            return self.tokens[self.index]
        return None
    
    def match(self, expected):
        if self.current_token() == expected:
            print(f"Matched {expected}")
            self.index += 1
        else:
            raise SyntaxError(f"Syntax Error")
        
    def parse_E(self):
        print("Parsing E")
        self.parse_T()
        self.parse_E_prime()
    
    def parse_E_prime(self):
        print("Parsing E prime")
        if self.current_token() == '+':
            self.match('+')
            self.parse_T()
            self.parse_E_prime()
        else:
            print('E -> eps')
    
    def parse_T(self):
        print("Parsing T")
        if self.current_token() == 'int':
            self.match('int')
        else:
            raise SyntaxError("Error")
    
    def parse(self):
        self.parse_E()
        if self.current_token() is not None:
            raise SyntaxError("Parsing Error")
        print("Parsing completed successfully")

tokens = ['int', '+', 'int', '+', 'int']
parser = Parser(tokens)
parser.parse()