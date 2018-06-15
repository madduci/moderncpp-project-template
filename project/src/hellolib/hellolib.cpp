#include "hellolib/hellolib.hpp"
#include <iostream>

using namespace hello;

int32_t hellolib::saySomething(const std::string &something) const noexcept {
  if (something.empty()) {
    std::cerr << "No value passed\n";
    return -1;
  }

  std::cout << something << '\n';
  return 0;
}