#!/bin/bash

echo "Compiling..."
nasm -f elf64 src/main.asm -o main.o
if [ $? -ne 0 ]; then
    echo "NASM compilation failed"
    exit 1
fi

echo "Linking..."
ld main.o -o ~/8_BIT_CPU
if [ $? -ne 0 ]; then
    echo "Linking failed"
    exit 2
fi

chmod +x ~/8_BIT_CPU

echo "Running..."
~/8_BIT_CPU 

echo $?