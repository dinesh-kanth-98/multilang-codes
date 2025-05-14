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
