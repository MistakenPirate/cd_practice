%{
#include"1.tab.h"
%}

%%
[0-9]+ {yylval = atoi(yytext); return NUMBER;}
"+" {return PLUS;}
"\n" {return EOL;}
%%

int yywrap() {
    return 1;
}