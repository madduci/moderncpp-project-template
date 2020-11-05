# moderncpp-project-template

![Static Build](https://github.com/madduci/moderncpp-project-template/workflows/Build-Static/badge.svg)

![Shared Build](https://github.com/madduci/moderncpp-project-template/workflows/Build-Shared/badge.svg)

This repository aims to represent a template for Modern C++ projects, including static analysis checks, autoformatting, a BDD/TDD capable test-suite and packaging

## Requirements

* a modern C++17 compiler (`gcc-8`, `clang-6.0`, `MSVC 2017` or above)
* [`cmake`](https://cmake.org) 3.10+
* [`conan`](https://conan.io) 1.4+
* `cppcheck` (optional)
* `clang-format` (optional)

## Repository layout

The repository follows the required files and folders as suggested in `conan_package_tools` documentation, with a folder dedicated to the source code and another one dedicated to testing the package as redistributable library, in case you are developing a library:

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

## How to build from command line

The project can be built using the following commands:

```shell
cd /path/to/this/project
mkdir -p build # md build (on Windows)
cd build
conan install ..
cmake -DBUILD_TESTING=TRUE ..
```

## How to build the project using a Docker Environment

### Linux/gcc

`docker run --rm -it -v $(pwd):/project madduci/docker-cpp-env:latest "mkdir -p build && cd build && conan install .. && cmake -DBUILD_TESTING=TRUE  .."`

### Windows/msvc

`docker run --rm -it -v $(pwd):/home/wine/.wine/drive_c/project madduci/docker-wine-msvc:16.7-2019`

and then:

```
md project/build
cd project/build
conan install .. cmake -DBUILD_TESTING=TRUE  ..
cmake --build .
```