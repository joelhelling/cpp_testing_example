#include "Virtual_class.h"
#include "gtest/gtest.h"

class Virtual_class_test : public testing::Test {
protected:
  Virtual_class virtual_class;
};

TEST_F(Virtual_class_test, some_function)
{
  EXPECT_EQ(0, virtual_class.some_function());
}
