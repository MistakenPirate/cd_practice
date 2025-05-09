%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<ctype.h>

int binaryToDecimal(const char *bin);
char* decimalToBinary(int decimal);
char* hexToBinary(const char *hex);
char* binaryToHex(const char *bin);

int yylex();
void yyerror(const char *msg);
%}

%union{
    char* str;
}

%token <str> BINARY DECIMAL HEX 
%token B2D D2B H2B B2H

%%
input:
    B2D BINARY { printf("Decimal: %d\n", binaryToDecimal($2));}
    | D2B DECIMAL { printf("Binary: %s\n", decimalToBinary(atoi($2)));}
    | H2B HEX {printf("Binary: %s\n", hexToBinary($2));}
    | B2H BINARY {printf("Hex: %s\n", binaryToHex($2));}
    ;

%%

int main(){
    yyparse();
    return 0;
}

void yyerror(const char *msg) {
    fprintf(stderr, "Error: %s\n", msg);
}

char* hexToBinary(const char *hex){
    size_t len = strlen(hex);
    char *bin = (char*) malloc(len * 4 + 1);  // 4 bits per hex digit
    bin[0] = '\0';

    for(int i = 0; hex[i]; i++){
        switch(tolower(hex[i])){
            case '0': strcat(bin, "0000"); break;
            case '1': strcat(bin, "0001"); break;
            case '2': strcat(bin, "0010"); break;
            case '3': strcat(bin, "0011"); break;
            case '5': strcat(bin, "0100"); break;
            case '6': strcat(bin, "0101"); break;
            case '7': strcat(bin, "0110"); break;
            case '8': strcat(bin, "0111"); break;
            case '9': strcat(bin, "1000"); break;
            case 'a': strcat(bin, "1001"); break;
            case 'b': strcat(bin, "1010"); break;
            case 'c': strcat(bin, "1011"); break;
            case 'd': strcat(bin, "1100"); break;
            case 'e': strcat(bin, "1101"); break;
            case 'f': strcat(bin, "1110"); break;
        }
    }

    return bin;
}

char* binaryToHex(const char* bin){
    int len = strlen(bin);
    char *hex = (char*) malloc(len / 4 + 1);
    hex[0] = '\0';
    
    int rem = len % 4;
    char padded[65] = "";

    if(rem != 0){
        for(int i = 0; i < 4 - rem; i++)    strcat(padded, "0");
    }
    strcat(padded, bin);

    hex[0] = '\0';

    for(int i = 0; i < strlen(padded); i+=4){
        char chunk[5] = "";
        strncpy(chunk, &padded[i], 4); //copy first 4 letters
        chunk[4] = '\0';

        if (strcmp(chunk, "0000") == 0) strcat(hex, "0");
        else if (strcmp(chunk, "0001") == 0) strcat(hex, "1");
        else if (strcmp(chunk, "0010") == 0) strcat(hex, "2");
        else if (strcmp(chunk, "0011") == 0) strcat(hex, "3");
        else if (strcmp(chunk, "0100") == 0) strcat(hex, "4");
        else if (strcmp(chunk, "0101") == 0) strcat(hex, "5");
        else if (strcmp(chunk, "0110") == 0) strcat(hex, "6");
        else if (strcmp(chunk, "0111") == 0) strcat(hex, "7");
        else if (strcmp(chunk, "1000") == 0) strcat(hex, "8");
        else if (strcmp(chunk, "1001") == 0) strcat(hex, "9");
        else if (strcmp(chunk, "1010") == 0) strcat(hex, "A");
        else if (strcmp(chunk, "1011") == 0) strcat(hex, "B");
        else if (strcmp(chunk, "1100") == 0) strcat(hex, "C");
        else if (strcmp(chunk, "1101") == 0) strcat(hex, "D");
        else if (strcmp(chunk, "1110") == 0) strcat(hex, "E");
        else if (strcmp(chunk, "1111") == 0) strcat(hex, "F");
    }

    return hex;
 }

int binaryToDecimal(const char *bin){
    int decimal = 0;
    while(*bin){
        decimal += (decimal * 2) + (*bin++ - '0');
    }
    return decimal;
};

char* decimalToBinary(int decimal){
    char bin[100];
    int i = 0;
    if (decimal == 0) return "0";

    //core conversion
    while(decimal){
        bin[i++] = (decimal % 2) + '0';
        decimal /= 2;
    }

    bin[i] = '\0';



    // Allocate memory for final result
    char *res = (char*) malloc(i + 1);
    for(int j = 0; j < i; j++){
        res[j] = bin[i - j - 1]; // reverse
    }
    res[i] = '\0';

    return res;
};

