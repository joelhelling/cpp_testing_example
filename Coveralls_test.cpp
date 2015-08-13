#include "Coveralls.h"
#include "gtest/gtest.h"
#include "gmock/gmock.h"

TEST(Coveralls_test, do_nothing)
{
  Coveralls coveralls;
  coveralls.get_val(10);
}
