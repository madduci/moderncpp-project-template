#####################################
# Define Project-Wide Settings
#####################################
cmake_minimum_required(VERSION 3.10.0)
project(moderncpp-project LANGUAGES CXX  VERSION 1.0.0 )
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_SKIP_BUILD_RPATH OFF)
set(CMAKE_BUILD_WITH_INSTALL_RPATH OFF)
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH ON)
set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_VISIBILITY_INLINES_HIDDEN 1)

#####################################
# Define Conan Imports
#####################################
include(GenerateExportHeader)
include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

#####################################
# Set compiler specific settings
#####################################

list(APPEND compiler_flags
  $<$<CXX_COMPILER_ID:MSVC>:/W4>
  $<$<CXX_COMPILER_ID:MSVC>:/WX>
  $<$<CXX_COMPILER_ID:MSVC>:/GL>
  $<$<CXX_COMPILER_ID:MSVC>:/Yu>
  $<$<CXX_COMPILER_ID:MSVC>:/O2>
  $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:CLANG>>:-Wall>
  $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:CLANG>>:-Wextra>
  $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:CLANG>>:-Werror=format-security>
  $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:CLANG>>:-Werror=unused-result>
  $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:CLANG>>:-fasynchronous-unwind-tables>
  $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:CLANG>>:-fexceptions>
  $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:CLANG>>:-pipe>
)

#####################################
# Define Targets
#####################################
include_directories(src)

set(PROJECT_TARGETS)
add_executable(hello src/hello.cpp)
target_compile_options(hello PRIVATE ${compiler_flags})
# Build statically or dynamically?
if(BUILD_SHARED_LIBS)
  add_library(hellolib SHARED src/hellolib/hellolib.cpp)
  generate_export_header(hellolib BASE_NAME hellolib)
  target_include_directories(hellolib PUBLIC ${PROJECT_BINARY_DIR})
  set_target_properties(hellolib
    PROPERTIES
      VERSION ${PROJECT_VERSION}
      PUBLIC_HEADER "src/hellolib/hellolib.hpp;${PROJECT_BINARY_DIR}/hellolib_export.h"
      POSITION_INDEPENDENT_CODE ON
  )
  target_compile_options(hellolib PRIVATE ${compiler_flags})
  set_target_properties(hello
    PROPERTIES
      POSITION_INDEPENDENT_CODE ON
  )
  if(MSVC)
    target_link_libraries(hellolib /MD)
    target_link_libraries(hello /MD)
  endif()
else()
  add_library(hellolib STATIC src/hellolib/hellolib.cpp)
  generate_export_header(hellolib BASE_NAME hellolib)
  target_include_directories(hellolib PUBLIC ${PROJECT_BINARY_DIR})
  set_target_properties(hellolib
    PROPERTIES
      COMPILE_DEFINITIONS HELLOLIB_STATIC_DEFINE
      PUBLIC_HEADER "src/hellolib/hellolib.hpp;${PROJECT_BINARY_DIR}/hellolib_export.h"
  )
  target_compile_options(hellolib PRIVATE ${compiler_flags})
  if(MSVC)
    target_link_libraries(hellolib /MT)
    target_link_libraries(hello /MT)
  else()
    target_link_libraries(hello -static)
  endif()
endif()

target_link_libraries(hello hellolib ${CONAN_LIBS})

#####################################
# Define Install Targets
#####################################

install(TARGETS
  hellolib
  hello
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  PUBLIC_HEADER DESTINATION include
)

#####################################
# Define Tests
#####################################
enable_testing()
list(APPEND TEST_CASES
  test_hello
)

foreach(TEST_CASE ${TEST_CASES})
  add_executable(${TEST_CASE} tests/${TEST_CASE}.cpp)
  target_link_libraries(${TEST_CASE} hellolib ${CONAN_LIBS})
  target_compile_options(${TEST_CASE} PRIVATE ${compiler_flags})
  add_test(NAME ${TEST_CASE}
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/bin
    COMMAND ${TEST_CASE})
endforeach(TEST_CASE ${TEST_CASES})