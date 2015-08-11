#include "Thing.h"
#include "gtest/gtest.h"
#include "gmock/gmock.h"

using testing::Return;

class VirtualClassMock : public Virtual_class {
public:
  MOCK_CONST_METHOD0(some_function, int());
};

class Thing_test : public testing::Test {
protected:
  Thing thing;
  VirtualClassMock virtualClassMock;
};

TEST_F(Thing_test, testDoSomething)
{
  int val = 10;
  ON_CALL(virtualClassMock, some_function())
    .WillByDefault(Return(val));
  EXPECT_CALL(virtualClassMock, some_function()).Times(1);
  EXPECT_EQ(val, thing.do_something(virtualClassMock));
}
