%{
#include"3.tab.h"
#include<string.h>
%}

%%
"b2d"   {return B2D;}
"d2b"   {return D2B;}
"h2b"   {return H2B;}
"b2h"   {return B2H;}
[0-1]+  {yylval.str = strdup(yytext); return BINARY;}
[0-9]+  {yylval.str = strdup(yytext); return DECIMAL;}
[a-fA-F0-9]+ {yylval.str = strdup(yytext); return HEX;}
[ \t]+              { /* ignore whitespace */ }
\n                  { return 0; }
%%

int yywrap(){
    return 1;
}