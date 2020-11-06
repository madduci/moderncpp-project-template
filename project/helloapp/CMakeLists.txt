# MIT License 
# Copyright (c) 2018-Today Michele Adduci <adduci@tutanota.com>
#
# helloapp target instructions

#####################################
# Define Target Information
#####################################
set(TARGET_NAME helloapp)
set(TARGET_INCLUDE_FOLDER ${CMAKE_CURRENT_SOURCE_DIR}/include)
set(TARGET_SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/src/helloapp.cpp)

#####################################
# Support IDE Visualization
#####################################
source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR} FILES ${TARGET_SOURCES})

#####################################
# Define Target according to options
#####################################
add_executable(${TARGET_NAME} ${TARGET_SOURCES})

#####################################
# Define Target Properties and Optional OpenSSL Dependency
#####################################

# add target properties such as debug postfix and MSVC runtime
set_target_properties(${TARGET_NAME} PROPERTIES DEBUG_POSTFIX "-d" MSVC_RUNTIME_LIBRARY "${MSVC_RUNTIME_TYPE}")

# set target compile options as defined in the cmake/compiler_options.cmake Module
target_compile_options(${TARGET_NAME} PRIVATE ${compiler_options})

# add compiler definition WITH_OPENSSL, if found
target_compile_definitions(${TARGET_NAME} PRIVATE ${compiler_definitions} $<$<BOOL:${OPENSSL_FOUND}>:WITH_OPENSSL>)

# set target link options as defined in the cmake/compiler_options.cmake Module
target_link_options(${TARGET_NAME} PRIVATE ${linker_flags})

# include all the necessary directories
target_include_directories(${TARGET_NAME}
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}/exports>
  PRIVATE 
    ${TARGET_INCLUDE_FOLDER}
    ${CMAKE_CURRENT_SOURCE_DIR}/../hellolib/include
    # Any other extra include required
)

# link against hellolib
target_link_libraries(${TARGET_NAME} PUBLIC hellolib)
