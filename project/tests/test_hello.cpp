#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include <doctest.h>

SCENARIO("Implementation shoud proceed successfully") {
  GIVEN("An implementation") {
    // WRITE here your implemented object
    WHEN("it is called correctly") {
      // WRITE here something
      auto return_code = 0;
      THEN("The return code should indicate success") {
        REQUIRE(return_code == 0);
      }
      AND_THEN("Something else") {
        // WRITE here something else
      }
    }
    AND_WHEN("its is called badly") {
      auto return_code = -1;
      THEN("The return code should indicate failure") {
        REQUIRE(return_code == -1);
      }
    }
  }
}