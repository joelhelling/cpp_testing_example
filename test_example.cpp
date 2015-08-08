#include "Example.h"
#include "submodules/Catch/single_include/catch.hpp"

TEST_CASE("Example")
{
  Example example;
  int test_val = 10;
  int negative_test_val = test_val * -1;

  SECTION("constructor - default")
  {
    REQUIRE( example.get_val() == 0 );
  }

  SECTION("constructor - positive")
  {
    Example example2{test_val};
    REQUIRE( example2.get_val() == test_val );
  }

  SECTION("constructor - negative")
  {
    Example example2{negative_test_val};
    REQUIRE( example2.get_val() == negative_test_val );
  }

  SECTION("set_val and get_val - positive")
  {
    example.set_val(test_val);
    REQUIRE( example.get_val() == test_val );

    example.set_val(++test_val);
    REQUIRE( example.get_val() == test_val);
  }

  SECTION("set_val and get_val - negative")
  {
    example.set_val(negative_test_val);
    REQUIRE( example.get_val() == negative_test_val );
  }
}
