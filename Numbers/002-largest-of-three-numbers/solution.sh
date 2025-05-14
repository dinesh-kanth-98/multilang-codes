#!/bin/bash

read -p "Enter The Num1: " num1
read -p "Enter the Num2: " num2
read -p "Enter the num3: " num3

if [[ "$num1" -ge "$num2" && "$num1" -ge "$num3" ]]; then
    echo "num1 is the largest Number"
elif [ "$num2" -ge "$num1" ] && [ "$num2" -ge "$num3" ]; then
    echo "number to is the largest number"
else
    echo "Number 3 is the Largest number"
fi
