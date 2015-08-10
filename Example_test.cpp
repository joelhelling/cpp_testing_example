#include "Example.h"
#include "gtest/gtest.h"


class ExampleTest : public testing::Test {
protected:
  // virtual void SetUp();
  // virtual void TearDown();

  const int test_val = 12;
  Example example{test_val};
};

TEST_F(ExampleTest, basicTest)
{
  EXPECT_EQ(test_val, example.get_val());
}
