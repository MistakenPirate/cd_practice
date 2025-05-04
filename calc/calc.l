%{
#include calc.tab.h
%}

%%
[ \t] ;
[0-9] {yylval = atoi(yytext); return NUMBER;}
"+"		return '+';
"-"		return '-';
"*"		return '*';
"/"		return '/';
"("		return '(';
")"		return ')';
\n		return '\n';
.		{ printf("Unknown characters: %s\n",yytext); }
%%

int yywrap(){
    return 1;
}