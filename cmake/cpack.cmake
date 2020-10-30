set(CPACK_PACKAGE_VENDOR "Michele Adduci <adduci@tutanota.com>")
set(CPACK_PACKAGE_VERSION_MAJOR "${${PROJECT_NAME}_MAJOR_VERSION}")
set(CPACK_PACKAGE_VERSION_MINOR "${${PROJECT_NAME}_MINOR_VERSION}")
set(CPACK_PACKAGE_VERSION_PATCH "${${PROJECT_NAME}_BUILD_VERSION}")
set(CPACK_SYSTEM_NAME "${${PROJECT_NAME}_BUILD_TAG}")
set(CPACK_GENERATOR "ZIP")
set(CPACK_STRIP_FILES "TRUE")

include(CPack)