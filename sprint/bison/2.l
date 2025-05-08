%{
#include "2.tab.h"
%}

%%
[0-9]+      { yylval = atoi(yytext); return NUMBER; }
"+"         { return PLUS; }
"-"         { return MINUS; }
"*"         { return MULT; }
"/"         { return DIV; }
"\n"        { return EOL; }
"("         { return LPAREN; }
")"         { return RPAREN; }
[ \t]       {/*Ignore Whitespace*/}
.           { return yytext[0]; }  // return the character as token
%%

int yywrap() {
    return 1;
}
