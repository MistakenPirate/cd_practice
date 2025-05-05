%{
#include <stdio.h>
#include <stdlib.h> //atoi
#include <string.h> //string funcs
#include <ctype.h> //toUpper

int binaryToDecimal(const char *bin);
char* decimalToBinary(int decimal);
char* hexToBinary(const char *hex);
char* binaryToHex(const char *bin);

int yylex();
void yyerror(const char *msg);

%}

%union {
    char* str;
}

%token <str> BINARY DECIMAL HEX
%token B2D D2B H2B B2H INVALID

%type <str> input

%%

input:
    B2D BINARY     { printf("Decimal: %d\n", binaryToDecimal($2)); }
  | D2B DECIMAL    { printf("Binary: %s\n", decimalToBinary(atoi($2))); }
  | H2B HEX        { printf("Binary: %s\n", hexToBinary($2)); }
  | B2H BINARY     { printf("Hex: %s\n", binaryToHex($2)); }
  ;

%%

int main() {
    printf("Enter command (e.g., b2d 1010):\n");
    yyparse();
    return 0;
}

void yyerror(const char *msg) {
    fprintf(stderr, "Error: %s\n", msg);
}


// Helper functions

int binaryToDecimal(const char *bin) {
    int decimal = 0;
    while (*bin) {
        decimal = decimal * 2 + (*bin++ - '0');
    }
    return decimal;
}

char* decimalToBinary(int decimal) {
    char bin[65];
    int i = 0;
    if (decimal == 0) return "0";

    //core converstion
    while (decimal > 0) {
        bin[i++] = (decimal % 2) + '0';
        decimal /= 2;
    }
    bin[i] = '\0';

    //reverse the string
    for (int j = 0; j < i / 2; j++) {
        char temp = bin[j];
        bin[j] = bin[i - j - 1];
        bin[i - j - 1] = temp;
    }
    return bin;
}

char* hexToBinary(const char *hex) {
    char bin[256] = "";

    //end of string to use the strcat func -> strcat will concat the string
    bin[0] = '\0';

    //so we are iterating all the hex nums and concatinating the binary of each

    for (int i = 0; hex[i]; i++) {

        //to upper from ctype.h
        switch(toupper(hex[i])) {
            case '0': strcat(bin, "0000"); break;
            case '1': strcat(bin, "0001"); break;
            case '2': strcat(bin, "0010"); break;
            case '3': strcat(bin, "0011"); break;
            case '4': strcat(bin, "0100"); break;
            case '5': strcat(bin, "0101"); break;
            case '6': strcat(bin, "0110"); break;
            case '7': strcat(bin, "0111"); break;
            case '8': strcat(bin, "1000"); break;
            case '9': strcat(bin, "1001"); break;
            case 'A': strcat(bin, "1010"); break;
            case 'B': strcat(bin, "1011"); break;
            case 'C': strcat(bin, "1100"); break;
            case 'D': strcat(bin, "1101"); break;
            case 'E': strcat(bin, "1110"); break;
            case 'F': strcat(bin, "1111"); break;
            default: return "Invalid Hex";
        }
    }
    return bin;
}

char* binaryToHex(const char *bin) {
    char hex[65] = "";
    int len = strlen(bin);
    int rem = len % 4;  //this is to determine if we need to pad the binary string
    char padded[65] = "";   //padded version of the binary string

    //add 0's to the start if padding is needed
    if (rem != 0) {
        for (int i = 0; i < 4 - rem; i++) strcat(padded, "0");
    }
    strcat(padded, bin);

    //again add this for strcat to work
    hex[0] = '\0';

    //iterate through the binary string by count of 4 and concat with respective hex
    for (int i = 0; i < strlen(padded); i += 4) {

        char chunk[5] = "";
        strncpy(chunk, &padded[i], 4);  //strncpy to copy n=4 chars
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
