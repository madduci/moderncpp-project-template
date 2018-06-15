#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include <doctest.h>
#include "hellolib/hellolib.hpp"

using namespace hello;

SCENARIO("Implementation shoud proceed successfully") {
  GIVEN("An implementation") {
    // WRITE here your implemented object
    hellolib hello{};
    WHEN("it is called correctly") {
      // WRITE here something
      auto return_code = hello.saySomething("I love BDD");
      THEN("The return code should indicate success") {
        REQUIRE(return_code == 0);
      }
    }
    AND_WHEN("its is called badly") {
      auto return_code = hello.saySomething("");
      THEN("The return code should indicate failure") {
        REQUIRE(return_code == -1);
      }
    }
  }
}