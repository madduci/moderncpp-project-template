# moderncpp-project-template

![Static Build](https://github.com/madduci/moderncpp-project-template/workflows/Build-Static/badge.svg)

![Shared Build](https://github.com/madduci/moderncpp-project-template/workflows/Build-Shared/badge.svg)

This repository aims to represent a template for Modern C++ projects, including static analysis checks, autoformatting, a BDD/TDD capable test-suite and packaging

## Requirements

* a modern C++17 compiler (`gcc-8`, `clang-6.0`, `MSVC 2017` or above)
* [`cmake`](https://cmake.org) 3.15+
* [`conan`](https://conan.io) 2.0+ (optional)
* `cppcheck` (optional)
* `clang-format` (optional)

## Features

* CMake-based project management, including dependencies
* Conan support for dependency management in CMake, completely optional
* Additional tools such as `clang-format` and `cppcheck`
* Support for shared/static libraries, including generation of export information
* Basic CPack configuration for redistributables
* GitHub Actions

## Repository layout

The repository layout is pretty straightforward, including the CMake files to build the project, a `conanfile` where are declared examples of dependencies, a suppression list for cppcheck and the C++ source code:

```plain
-- conanfile.txt                - the main `conan` configuration file listing dependencies
-- cppcheck_suppressions.txt    - optional list of suppressions for cppcheck
-- CMakeLists.txt               - the main `CMake` Project configuration file
-- .dockerignore                - files to be excluded by Docker
-- .gitignore                   - files to be excluded by git
+- `cmake/`                     - CMake modules
  | -- clang-format.cmake       - CMake target definitions for clang-format
  | -- compiler-options.cmake   - Common compiler options for major platforms/compilers
  | -- cpack.cmake              - Packaging configuration with CPack
  | -- dependencies.cmake       - Project dependencies, CMake-Style
+- `project/`                   - the whole C++ project
  | -- .clang-format            - the formatter rules for the C++ project
  | -- CMakeLists.txt
  | +- `helloapp/`              - your application files (including CMakeLists.txt, sources)
  | +- `hellolib/`              - your library files (including CMakeLists.txt, sources
+- `build/`                     - working directory for the build
```

## Available CMake Options

* BUILD_TESTING     - builds the tests (requires `doctest`)
* BUILD_SHARED_LIBS - enables or disables the generation of shared libraries
* BUILD_WITH_MT     - valid only for MSVC, builds libraries as MultiThreaded DLL

If you activate the `BUILD_TESTING` flag, you need to perform in advance a `conan install` step, just to fetch the `doctest` dependency. Another dependency (OpenSSL) is used in this project as a demonstration of including a third-party library in the process, but it is totally optional and you can activate it only if you run conan in advance.

## How to build from command line

The project can be built using the following commands:

```shell
cd /path/to/this/project
mkdir -p build # md build (on Windows)
cd build
conan install .. --output-folder=. --build=missing
cmake -DBUILD_TESTING=TRUE -DBUILD_SHARED_LIBS=TRUE -DCMAKE_BUILD_TYPE=Release ..
cmake --build .
cmake --build . --target format
cmake --build . --target package
```

## How to build the project using a Docker Environment

### Linux/gcc

`docker run --rm -it -v $(pwd):/project madduci/docker-cpp-env:latest "mkdir -p build && cd build && conan install .. && cmake -DBUILD_TESTING=TRUE -DBUILD_SHARED_LIBS=TRUE .. && cmake --build ."`

### Windows/msvc

`docker run --rm -it -v $(pwd):/home/wine/.wine/drive_c/project madduci/docker-wine-msvc:17.8-2022`

and then:

```
md project/build
cd project/build
conan install --output-folder .  .. 
cmake -G "Ninja" -DBUILD_TESTING=TRUE  ..
cmake --build .
```
