# MIT License 
# Copyright (c) 2018-Today Michele Adduci <michele@adduci.org>
#
# Packaging instructios

set(CPACK_PACKAGE_VENDOR "Michele Adduci <michele@adduci.org>")
set(CPACK_PACKAGE_VERSION_MAJOR "${CMAKE_PROJECT_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${CMAKE_PROJECT_VERSION_MINOR}")
set(CPACK_PACKAGE_VERSION_PATCH "${CMAKE_PROJECT_VERSION_PATCH}")
set(CPACK_GENERATOR "ZIP;TGZ")
set(CPACK_STRIP_FILES "TRUE")

include(CPack)