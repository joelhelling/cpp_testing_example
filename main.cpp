#include "Example.h"
#include <iostream>

using namespace std;

int main()
{
  Example example{10};
  cout << "Example: " << example.get_val() << endl;
}
