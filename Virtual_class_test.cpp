#include "Virtual_class.h"
#include "gtest/gtest.h"

class VirtualClassTest : public testing::Test {
protected:
  Virtual_class virtual_class;
};

TEST_F(VirtualClassTest, testSomeFunction)
{
  EXPECT_EQ(0, virtual_class.some_function());
}
