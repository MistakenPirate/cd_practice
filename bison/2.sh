#!/bin/bash

echo "Cleaning up previous build files..."
rm -f lex.yy.c 2.tab.c 2.tab.h a.out

echo "Running Flex..."
flex 2.l

echo "Running Bison..."
bison -d 2.y

echo "Compiling..."
gcc -o calc2 lex.yy.c 2.tab.c

echo "Running the calculator..."
./calc2
