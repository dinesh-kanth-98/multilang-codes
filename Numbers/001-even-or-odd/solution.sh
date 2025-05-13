#!/bin/bash

main()
{
    read -rp "Enter a Number: " num

    if [ $(expr $num % 2) == 0 ]; then
#     if (( num % 2 == 0 )); then   /* another Synatx Which Works*/
        echo "the number is even"
    else
        echo "The number is odd"
    fi

}

main
