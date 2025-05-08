%{
#include<stdio.h>
int paren = 0;
%}

%%
"(" {paren++;}
")" {
    paren--;
    if(paren < 0){
        printf("Unbalanced\n");
        return 0;
    }
}
[^()\n]+ {}
"\n" {
    if(paren == 0)
        printf("Balanced\n");
    else
        printf("Unbalanced\n");
}
%%

int main(){
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}