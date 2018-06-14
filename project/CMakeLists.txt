#####################################
# Define Project-Wide Settings
#####################################
cmake_minimum_required(VERSION 3.9.0)
project(moderncpp-project CXX)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

#####################################
# Define Conan Imports
#####################################
include(GenerateExportHeader)
include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

#####################################
# Define Targets
#####################################
include_directories(src)
add_executable(hello src/hello.cpp)
set_target_properties(hello PROPERTIES POSITION_INDEPENDENT_CODE ON)
# Build statically?
if(NOT BUILD_SHARED_LIBS)
  if(MSVC)
    target_link_libraries(hello /MT)
  else()
    target_link_libraries(hello -static)
  endif()
endif()
target_link_libraries(hello ${CONAN_LIBS})

#####################################
# Define Tests
#####################################
enable_testing()
list(APPEND TEST_CASES
  test_hello
)

foreach(TEST_CASE ${TEST_CASES})
  add_executable(${TEST_CASE} tests/${TEST_CASE}.cpp)
  target_link_libraries(${TEST_CASE} ${CONAN_LIBS})
  add_test(NAME ${TEST_CASE}
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/bin
    COMMAND ${TEST_CASE})
endforeach(TEST_CASE ${TEST_CASES})