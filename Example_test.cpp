#include "Example.h"
#include "gtest/gtest.h"

class Example_test : public testing::Test {
protected:
  const int test_val = 12;
  Example example{test_val};
};

TEST_F(Example_test, get_val)
{
  EXPECT_EQ(test_val, example.get_val());
}

TEST_F(Example_test, set_val)
{
  int val = test_val + 1;
  example.set_val(val);
  EXPECT_EQ(val, example.get_val());
}
