# Problem Description

Check if a number is even or odd

---

## Solution in C

```c
#include <stdio.h>

int main()
{
    int num;
    printf("Enter the number: ");
    scanf("%d", &num);

    if(num % 2 == 0)
    {
        printf("the number is even\n");
    }
    else
    {
        printf("The number is odd\n");
    }
}
```

## Solution in C++

```cpp
#include <iostream>
using namespace std;

int main()
{
     int number;

     cout << "Enter The Number: ";
     cin >> number;

     if( number % 2 == 0 )
     {
     cout << "the number is even " << endl;
    }
    else
    {
        cout << "the number is odd" << endl;
    }

}
```

## Solution in Python

```python

def main():
    number=int(input("Enter Number: "))

    if number %2 == 0:
        print("the number is even")
    else:
        print("Thr Number Is odd")


if __name__ == "__main__" :
    main()
```

## Solution in Bash

```bash
```

## Solution in Expect

```expect
```

