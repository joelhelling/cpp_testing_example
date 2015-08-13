#include "Bad_coverage.h"

int blah_blah(int input)
{
  if (input == 1) {
    return 2;
  }
  if (input == 3) {
    return 4;
  }
  if (input == 5) {
    return 6;
  }
  return input * -1;
}
