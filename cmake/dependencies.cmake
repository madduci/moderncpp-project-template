# MIT License 
# Copyright (c) 2018-Today Michele Adduci <michele@adduci.org>
#
# Dependencies

# Required for Testing
if(BUILD_TESTING)
  find_package(doctest REQUIRED)
endif()

# Optional Dependency, doesn't trigger error if missing
find_package(OpenSSL)