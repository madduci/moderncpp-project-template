# moderncpp-project-template

This repository aims to represent a template for Modern C++ projects, including static analysis checks, autoformatting, a BDD/TDD capable test-suite and packaging

## Requirements

* a modern C++17 compiler (`gcc-8`, `clang-6.0`, `MSVC 2017` or above)
* [`cmake`](https://cmake.org) 3.9+
* [`conan`](https://conan.io) 1.4+
* `conan_package_tools` (optional)
* `cppcheck` (optional) 1.80+
* `clang-format` (optional)
* `clang-check` (optional)

## Repository layout

The repository follows the required files and folders as suggested in `conan_package_tools` documentation, with a folder dedicated to the source code and another one dedicated to testing the package as redistributable library, in case you are developing a library:

```plain
-- conanfile.py      - the main `conan` configuration file
-- build.py          - python script to launch the `conan_package_tools` tests
-- .dockerignore     - files to be excluded by Docker
-- .gitignore        - files to be excluded by git
+- `project/`        - the whole C++ project
  | -- .clang-format - the formatter rules for the C++ project
  | -- CMakeLists.txt
  | +- `src/`        - your source files
  |    -- hello.cpp
  | +- `tests/`      - your unit tests
  |   -- test_hello.cpp
+- `test_package/`   - integration or usage example
  | -- CMakeLists.txt
  | -- conanfile.py
  | -- usage_hello.cpp
+- `build/`          - working directory for the build
```

## How to build from command line

The project can be built using the following commands:

```shell
cd /path/to/this/project
mkdir -p build # md build (on Windows)
cd build
conan install ..
conan build ..
```

## How to build the project using a Docker Environment

`docker run --rm -it -v $(pwd):/project madduci/docker-cpp-env:latest "mkdir -p build && cd build && conan install .. && conan build .."`
