#include "Example.h"
#include "gtest/gtest.h"


class ExampleTest : public testing::Test {
protected:
  // virtual void SetUp();
  // virtual void TearDown();

  const int test_val = 12;
  Example example{test_val};
};

TEST_F(ExampleTest, testGetVal)
{
  EXPECT_EQ(test_val, example.get_val());
}

TEST_F(ExampleTest, testSetVal)
{
  int val = test_val + 1;
  example.set_val(val);
  EXPECT_EQ(val, example.get_val());
}
