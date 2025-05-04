%{
#include <stdio.h>
int paren = 0;
%}

%%
"("  {paren++;}
")"  {
     paren--;
     if(paren < 0)
	printf("Unbalanced\n");
	fflush(stdout);
        return 0;
     }
[^()\n]+ {}

"\n" {
     paren == 0 ? printf("Balanced\n"):printf("Unbalanced\n");
     fflush(stdout);
     paren = 0;
     return 0;
     }


%%

int main(){
  yylex();
  return 0;
}

int yywrap(){
  return 1;
}
