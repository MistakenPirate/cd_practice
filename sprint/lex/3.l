%{
#include<stdio.h>
int res = 0;
char op = '+';
%}

%%
[+\-*/] {op = yytext[0];}
[0-9]+ {
    int num = atoi(yytext);
    switch(op){
        case '+' : res += num; break;
        case '-' : res -= num; break;
        case '*' : res *= num; break;
        case '/' : {
            if(num == 0){
                printf("Can't divide by zero");
                return 0;
            }
            res /= num;
            break;
        }
    }
    printf("= %d\n", res);
}
%%

int main(){
    printf("Enter the expression:\n");
    yylex();
    printf("Final Result: %d\n", res);
    return 0;
}

int yywrap() {
    return 1;
}