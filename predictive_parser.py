# E  → T E'
# E' → + T E' | eps
# T  → int

class Parser:
    def __init__(self, tokens):
        self.tokens = tokens
        self.current_token_index = 0
    
    def current_token(self):
        if self.current_token_index < len(self.tokens):
            return self.tokens[self.current_token_index]
        return None

    def match(self, expected_token):
        if self.current_token() == expected_token:
            print(f"Matched: {expected_token}")
            self.current_token_index += 1
        else:
            raise SyntaxError(f"Error: {expected_token}, got {self.current_token()}")
        
    def parse_E(self):
        print("Parsing E")
        self.parse_T()
        self.parse_E_prime()

    def parse_E_prime(self):
        print("Parsing E Prime'")
        if self.current_token() == '+':
            self.match('+')
            self.parse_T()
            self.parse_E_prime()
        else:
            print("E' → eps")

    def parse_T(self):
        print("Parsing T")
        if self.current_token() == 'int':
            self.match('int')
        else:
            raise SyntaxError(f"Expected 'int', got {self.current_token()}")
        
    def parse(self):
        self.parse_E()
        if self.current_token() is not None:
            raise SyntaxError(f"Unexpected token {self.current_token()} at the end")
        print("Parsing completed successfully!")

tokens = ['int', '+', 'int', '+', 'int']
parser = Parser(tokens)
parser.parse()

