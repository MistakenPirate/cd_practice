%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char* s);
int yylex();
%}

%token PLUS MINUS MULT DIV EOL LPAREN RPAREN NUMBER

%left PLUS MINUS
%left MULT DIV

%%

input:
    | input line
    ;

line:
    expr EOL   {printf("%d\n",$$)}
    ;

expr:
    expr PLUS expr {$$ = $1 + $3;}
    | expr MINUS expr {$$ = $1 - $3;}
    | expr MULT expr {$$ = $1 - $3;}
    | expr DIV expr {
        if($3 == 0){
            printf("Cant divide by 0\n");
            return 0;
        } else {
            $$ = $1 / $3;
        }
    }
    | LPAREN expr RPAREN {$$ = $2;}
    | NUMBER {$$ = $1;}
    ;

%%

void yyerror(const char* s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter expressions (Ctrl+D to exit):\n");
    yyparse();
    return 0;
}
