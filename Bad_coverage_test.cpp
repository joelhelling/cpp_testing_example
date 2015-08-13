#include "Bad_coverage.h"
#include "gtest/gtest.h"

TEST(Bad_coverage_test, blah_blah)
{
  EXPECT_EQ(2, blah_blah(1));
  EXPECT_EQ(4, blah_blah(3));
  EXPECT_EQ(6, blah_blah(5));
  EXPECT_EQ(-7, blah_blah(7));
  EXPECT_EQ(0, blah_blah(0));
}
