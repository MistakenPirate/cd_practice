#!/bin/bash

echo "Cleaning up previous build files..."
rm -f lex.yy.c convert.tab.c convert.tab.h a.out

echo "Running Flex..."
flex convert.l

echo "Running Bison..."
bison -d convert.y

echo "Compiling..."
gcc -o conv lex.yy.c convert.tab.c

echo "Running the converter..."
./conv
