#include "Example.h"
#include "gtest/gtest.h"

const int test_val = 12;

class ExampleTest : public testing::Test {
protected:
  // virtual void SetUp();
  // virtual void TearDown();

  Example example{test_val};
};

TEST_F(ExampleTest, basicTest)
{
  EXPECT_EQ(test_val, example.get_val());
}
