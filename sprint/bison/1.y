%{
#include<stdio.h>

void yyerror(const char *s);
int yyparse();
int yylex();
%}

%token NUMBER PLUS EOL

%%
input:  
    //empty input allowed
    | input line
    ;

line:
    expression EOL
    {printf("%d\n", $1);}
    ;

expression:
    expression PLUS term {$$ = $1 + $3;}
    | term {$$ = $1;}
    ;

term:
    NUMBER {$$ = $1;}
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