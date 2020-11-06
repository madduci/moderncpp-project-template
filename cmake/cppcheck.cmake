# MIT License 
# Copyright (c) 2018-Today Michele Adduci <adduci@tutanota.com>
#
# cppcheck instructions

find_program(CPPCHECK_BIN NAMES cppcheck)

if(CPPCHECK_BIN)
  message(STATUS "Found: cppcheck")
  list(
        APPEND CMAKE_CXX_CPPCHECK 
            "${CPPCHECK_BIN}"
            "--enable=all"
            "--enable=warning,performance,portability,information"
            "--inconclusive"
            "--check-config"
            "--force" 
            "--inline-suppr"
            "--suppressions-list=${CMAKE_SOURCE_DIR}/cppcheck_suppressions.txt"
            "--xml"
            "--output-file=${CMAKE_BINARY_DIR}/cppcheck.xml"
    )
endif()
