%{
#include <stdio.h>

void yyerror(const char *s);
int yylex();
int yyparse();
%}

%token NUMBER PLUS EOL

%%
input:
    /* empty */               // Allows the input to be empty
  | input line                // Allows multiple lines of input
  ;

line:
    expr EOL                  // A complete line is an expression followed by a newline
    { printf("= %d\n", $1); } // After parsing, print the result of the expression
  ;

expr:
    expr PLUS term            // Handles expressions like 1 + 2 + 3 by left recursion
    { $$ = $1 + $3; }         // $1 is left expr, $3 is term; sum them and return as result
  | term                      // A plain term (like a single number) is also a valid expr
    { $$ = $1; }
  ;

term:
    NUMBER                    // A term is just a number
    { $$ = $1; }
  ;
%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}


int main() {
    printf("Enter expression:\n");
    yyparse();
    return 0;
}