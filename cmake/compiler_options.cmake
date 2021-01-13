# MIT License 
# Copyright (c) 2018-Today Michele Adduci <adduci@tutanota.com>
#
# Compiler options with hardening flags

if(MSVC)

  list(APPEND compiler_options 
    /W4
    /permissive-
    $<$<CONFIG:RELEASE>:/O2 /Ob2 >
    $<$<CONFIG:MINSIZEREL>:/O1 /Ob1>
    $<$<CONFIG:RELWITHDEBINFO>:/Zi /O2 /Ob1>
    $<$<CONFIG:DEBUG>:/Zi /Ob0 /Od /RTC1>)

  list(APPEND compiler_definitions
    _UNICODE
    WINDOWS
    $<$<OR:$<CONFIG:RELEASE>,$<CONFIG:RELWITHDEBINFO>,$<CONFIG:MINSIZEREL>>:NDEBUG>
    $<$<CONFIG:DEBUG>:_DEBUG>)

  list(APPEND linker_flags
    $<$<BOOL:${BUILD_SHARED_LIBS}>:/LTCG>
  )

  set(MSVC_RUNTIME_TYPE $<IF:$<BOOL:${BUILD_WITH_MT}>,MultiThreaded$<$<CONFIG:Debug>:Debug>,MultiThreaded$<$<CONFIG:Debug>:Debug>>DLL)

else(MSVC)

  list(APPEND compiler_options 
      -Wall
      -Wextra
      -Wpedantic
      $<$<CONFIG:RELEASE>:-O2>
      $<$<CONFIG:DEBUG>:-O0 -g -p -pg>)

  list(APPEND compiler_definitions
   $<$<OR:$<CONFIG:RELEASE>,$<CONFIG:MINSIZEREL>>:_FORTIFY_SOURCE=2>
  )
 
 list(APPEND linker_flags
 $<$<NOT:$<CXX_COMPILER_ID:AppleClang>>:-Wl,-z,defs>
 $<$<NOT:$<CXX_COMPILER_ID:AppleClang>>:-Wl,-z,now>
 $<$<NOT:$<CXX_COMPILER_ID:AppleClang>>:-Wl,-z,relro>
 # Clang doesn't support these hardening flags
 $<$<AND:$<NOT:$<CXX_COMPILER_ID:AppleClang>>,$<NOT:$<CXX_COMPILER_ID:Clang>>,$<NOT:$<BOOL:${BUILD_SHARED_LIBS}>>>:-Wl,-pie>
 $<$<AND:$<NOT:$<CXX_COMPILER_ID:AppleClang>>,$<NOT:$<CXX_COMPILER_ID:Clang>>,$<NOT:$<BOOL:${BUILD_SHARED_LIBS}>>>:-fpie>
 $<$<AND:$<NOT:$<CXX_COMPILER_ID:AppleClang>>,$<NOT:$<CXX_COMPILER_ID:Clang>>,$<NOT:$<BOOL:${BUILD_SHARED_LIBS}>>>:-pipe>
 $<$<AND:$<NOT:$<CXX_COMPILER_ID:AppleClang>>,$<NOT:$<CXX_COMPILER_ID:Clang>>,$<NOT:$<BOOL:${BUILD_SHARED_LIBS}>>>:-static-libstdc++>
 $<$<CONFIG:DEBUG>:-fno-omit-frame-pointer>
 $<$<CONFIG:DEBUG>:-fsanitize=address>
 $<$<CONFIG:DEBUG>:-fsanitize=leak>
 $<$<CONFIG:DEBUG>:-fsanitize=undefined>
 $<$<AND:$<NOT:$<CXX_COMPILER_ID:AppleClang>>,$<NOT:$<CXX_COMPILER_ID:Clang>>>:-fstack-clash-protection>
 $<$<AND:$<NOT:$<CXX_COMPILER_ID:AppleClang>>,$<NOT:$<CXX_COMPILER_ID:Clang>>>:-fbounds-check>
 -fstack-protector
 -fPIC)

endif()
