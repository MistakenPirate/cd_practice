%{
#include <stdio.h>
%}

%%
[0-9]+ {printf("Digit: %s\n", yytext);}
[a-zA-Z]+ {printf("Word: %s\n", yytext);}
.|\n {/*ignore*/}
%%

int main(){
  yylex();
  return 0;
}

int yywrap(){
  return 1;
}
