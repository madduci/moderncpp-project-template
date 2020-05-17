cmake_minimum_required(VERSION 3.10.0)
project(moderncpp_package_test CXX)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

enable_testing()
add_executable(usage_test usage_test.cpp)
target_link_libraries(usage_test ${CONAN_LIBS})
add_test(NAME usage_test
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/bin
  COMMAND usage_test)
