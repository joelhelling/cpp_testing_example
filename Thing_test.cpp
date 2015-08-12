#include "Thing.h"
#include "gtest/gtest.h"
#include "gmock/gmock.h"

using testing::Return;

class Virtual_class_mock : public Virtual_class {
public:
  MOCK_CONST_METHOD0(some_function, int());
};

class Thing_test : public testing::Test {
protected:
  Thing thing;
  Virtual_class_mock virtual_class_mock;
};

TEST_F(Thing_test, do_something)
{
  int val = 10;
  ON_CALL(virtual_class_mock, some_function())
    .WillByDefault(Return(val));
  EXPECT_CALL(virtual_class_mock, some_function()).Times(1);
  EXPECT_EQ(val, thing.do_something(virtual_class_mock));
}
