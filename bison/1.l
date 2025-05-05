%{
#include "1.tab.h" // This comes from Bison
#include <stdlib.h>
%}

%%
[0-9]+      { yylval = atoi(yytext); return NUMBER; }
"+"         { return PLUS; }
\n          { return EOL; }
[ \t]       ; // skip whitespace
.           { }
%%

int yywrap() {
    return 1;
}
