#!/bin/bash

# Clean up previous builds
echo "Cleaning up previous build files..."
rm -f lex.yy.c 1.tab.c 1.tab.h a.out

# Run Flex to generate lex.yy.c
echo "Running Flex..."
flex 1.l

# Run Bison to generate 1.tab.c and 1.tab.h
echo "Running Bison..."
bison -d 1.y

# Compile the generated C files
echo "Compiling..."
gcc -o calc lex.yy.c 1.tab.c

# Run the compiled program
echo "Running the calculator..."
./calc
