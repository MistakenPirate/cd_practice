%{
#include<stdio.h>
#include<ctype.h>
%}

%%
[a-zA-Z]+ {
    char first = tolower(yytext[0]);
    if(first == 'a' || first == 'e' || first == 'i' || first == 'o' || first == 'u')
        printf("'%s' starts with a vowel\n", yytext);
    else
        printf("'%s' starts with a consonant\n", yytext);
}
%%

int main(){
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}