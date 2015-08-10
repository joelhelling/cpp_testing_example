#include "Example.h"
#include <iostream>

using namespace std;

int main()
{
  Example example{10};
  cout << example.get_val() << endl;
}