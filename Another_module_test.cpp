#include "Another_module.h"
#include "gtest/gtest.h"

TEST(AnotherModuleTest, basicTest)
{
  EXPECT_EQ(15, another_function());
}
