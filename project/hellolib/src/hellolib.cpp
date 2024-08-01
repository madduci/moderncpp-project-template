#include "hellolib.h"

#include <iostream>

#ifdef WITH_OPENSSL
#include <openssl/evp.h>

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

  EVP_MD_CTX *context = EVP_MD_CTX_new();
  if (context == NULL) {
    std::cerr << "Failed to create context\n";
    return 2;
  }

  if (1 != EVP_DigestInit_ex(context, EVP_sha256(), NULL)) {
    std::cerr << "Failed to initialize context\n";
    return 3;
  }

  if (1 != EVP_DigestUpdate(context, (unsigned char *)something.c_str(),
                            something.size())) {
    std::cerr << "Failed to create hash value\n";
    return 4;
  }

  std::array<unsigned char, 32> buffer{};
  if (1 != EVP_DigestFinal_ex(context, buffer.data(), NULL)) {
    std::cerr << "Failed to finalize hash result\n";
    return 5;
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