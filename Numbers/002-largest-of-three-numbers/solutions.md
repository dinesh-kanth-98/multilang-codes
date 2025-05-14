# Problem Description

Find the largest of three numbers

---

## Solution in C

```c
#include <stdio.h>

int main()
{
    int a, b, c, max;

    printf("Enter three numbers: ");
    scanf("%d %d %d", &a, &b, &c);

    max=a;
    if(b > max)
        max = b;

    if (c > max)
        max = c;

    printf("max Number Is: %d\n", max);
}

```

## Solution in C++

```cpp
#include <iostream>
#include <algorithm>
using namespace std;
int main()
{
    int a,b,c;
    cout << "Enter Three Numbers: ";
    cin >> a >> b >> c;

    int largest = max({a, b, c});

    cout << "max number :" << largest << endl;
}
```

## Solution in Python

```python
num1=int(input("Enter First Number: "))
num2=int(input("Enter Second Number: "))
num3=int(input("Enter third Number: "))

largest = max(num1,num2,num3)

print("Max Number id", largest)
```

## Solution in Bash

```bash
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
```

## Solution in Expect

```expect
#!/usr/bin/expect

send_user "Enter first number: "
expect_user -re "(.*)\n"
set num1 $expect_out(1,string)

send_user "Enter second number: "
expect_user -re "(.*)\n"
set num2 $expect_out(1,string)

send_user "Enter third number: "
expect_user -re "(.*)\n"
set num3 $expect_out(1,string)

#convert inputs to numbers
set num1 [expr {$num1 + 0}]
set num2 [expr {$num2 + 0}]
set num3 [expr {$num3 + 0}]

if { $num1 >= $num2 && $num1 >= $num3 } {
    send_user "$num1 is the largest number.\n"
} elseif { $num2 >= $num1 && $num2 >= $num3 } {
    send_user "$num2 is the largest number.\n"
} else {
    send_user "$num3 is the largest number.\n"
}
```

