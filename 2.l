%{
#include <stdio.h>
%}

%%
[a-zA-Z]+ {
	char first = yytext[0];
	if(first == 'a' || first == 'e' || first == 'i' || first == 'o' || first == 'u'){
      printf("%s starts with a vowel\n", yytext);
    }
    else{
      printf("%s doesn't with a vowel\n", yytext);
    }
  }
.|\n {/*ignore*/}
%%

int main(){
  yylex();
  return 0;
}

int yywrap(){
  return 1;
}
