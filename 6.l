%{

#include <stdio.h>
#include <stdlib.h>

int result = 0;
char op = '+';
%}

%%
[0-9]+ {
    int num = atoi(yytext);
    switch(op){
      case '+': result += num; break;
      case '-': result -= num; break;
      case '*': result *= num; break;
      case '/': result /= num; break;
     // default: printf("Valid operator please"); return 0;
    }
    printf("= %d\n", result);
  }

[+\-*/] {op = yytext[0];}
[ \t\n] ;
.       {printf("Invalid: %s\n", yytext);} 
%%

int main(){
    printf("Enter expression (e.g., 3 + 5 * 2):\n");
    yylex();
    printf("Final Result: %d\n", result);
    return 0;
}

int yywrap(){
    return 1;
}
