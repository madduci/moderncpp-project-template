# Copyright 2020 Michele Adduci <adduci@tutanota.com>

# Required for Testing
if(BUILD_TESTING)
  find_package(doctest REQUIRED)
endif()

# Optional Dependency, if found
find_package(OpenSSL)