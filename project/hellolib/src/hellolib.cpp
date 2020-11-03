#include "hellolib.h"
#include <iostream>

#ifdef WITH_OPENSSL
#include <openssl/sha.h>
#include <array>
#include <iomanip>
#include <sstream>
#endif

using namespace hello;

int32_t hellolib::saySomething(const std::string &something) const noexcept {
  if (something.empty()) {
    std::cerr << "No value passed\n";
    return 1;
  }

  std::cout << something << '\n';
  return 0;
}

#ifdef WITH_OPENSSL
int32_t hellolib::saySomethingHashed(
    const std::string &something) const noexcept {
  if (something.empty()) {
    std::cerr << "No value passed\n";
    return 1;
  }

  SHA256_CTX context;
  if (!SHA256_Init(&context)) {
    std::cerr << "Failed to initialize context\n";
    return 2;
  }

  if (!SHA256_Update(&context, (unsigned char *)something.c_str(),
                     something.size())) {
    std::cerr << "Failed to create hash value\n";
    return 3;
  }

  std::array<unsigned char, 32> buffer{};
  if (!SHA256_Final(buffer.data(), &context)) {
    std::cerr << "Failed to finalize hash result\n";
    return 4;
  }

  // Transform byte-array to string
  std::stringstream shastr;
  shastr << std::hex << std::setfill('0');
  for (const auto &byte : buffer) {
    shastr << std::setw(2) << (int)byte;
  }

  std::cout << shastr.str() << '\n';
  return 0;
}
#endif