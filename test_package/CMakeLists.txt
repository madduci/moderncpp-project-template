cmake_minimum_required(VERSION 3.10.0)
project(moderncpp_package_test CXX)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

enable_testing()
list(APPEND TEST_CASES
usage_test
)

foreach(TEST_CASE ${TEST_CASES})
  add_executable(${TEST_CASE} ${TEST_CASE}.cpp)
  target_link_libraries(${TEST_CASE}  hellolib)
  target_compile_options(${TEST_CASE} PRIVATE ${compiler_flags})
  add_test(NAME ${TEST_CASE}
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/bin
    COMMAND ${TEST_CASE})
endforeach(TEST_CASE ${TEST_CASES})