from conans import ConanFile, CMake, tools
import os
import subprocess


class ModernCppProject(ConanFile):
    name = "moderncpp-project-template"
    version = "1.0.0"
    description = "Modern C++ Project Template"
    topics = ("conan", "cpp", "template")
    url = "https://gitlab.com/madduci/moderncpp-project-template"
    homepage = "https://madduci.netlify.app"
    license = "MIT"
    exports_sources = ["CMakeLists.txt", "project/*"]
    generators = "cmake"
    short_paths = True
    settings = "os", "arch", "compiler", "build_type"
    options = {"shared": [True, False], "fPIC": [True, False]}
    default_options = {"shared": False, "fPIC": True}

    def config_options(self):
        if self.settings.os == 'Windows':
            del self.options.fPIC

        if self.settings.compiler == "gcc" or self.settings.compiler == "clang":
            self.settings.compiler.libcxx = "libstdc++11"

    def source(self):
        '''Format files if clang-format is available'''
       # if tools.which('clang-format') is not None:
          #  self.__clang_format()

    def build(self):
        '''Setup CMake project
           Builds the source files and runs the tests'''
        cmake = CMake(self, set_cmake_flags=True)
        cmake.configure()
        cmake.build()
        cmake.install()

    def package(self):
        self.copy("*.h", dst="include", src="hello")
        self.copy("*.lib", dst="lib", keep_path=False)
        self.copy("*.dll", dst="bin", keep_path=False)
        self.copy("*.so", dst="lib", keep_path=False)
        self.copy("*.dylib", dst="lib", keep_path=False)
        self.copy("*.a", dst="lib", keep_path=False)

    def package_info(self):
        self.cpp_info.libs = [self.name]

    def __list_files(self, extensions):
        '''Finds all the files by extension'''
        found_files = []
        for path, subdirs, files in os.walk(self.project_dir):
            for file in files:
                extension = os.path.splitext(file)[1]
                for ext in extensions:
                    if ext == extension:
                        found_files.append(os.path.join(path, file))

        return found_files

    def __clang_check(self):
        '''Performs clang-check on compiled files'''
        files = self.__list_files(self.project_cpp_files_extensions)
        for file in files:
            subprocess.Popen(
                ['clang-check', '-analyze', "-p=%s" % self.build_dir, file],
                stderr=subprocess.PIPE
            )

    def __clang_format(self):
        '''Performs clang-format on all C++ files'''
        files = self.__list_files(self.project_files_extensions)
        for file in files:
            subprocess.Popen(
                ['clang-format', '-style=file', '-i', file],
                stderr=subprocess.PIPE
            )

    def __cppcheck(self):
        '''Performs clang-format on all C++ files'''
        build_path = os.path.join(self.build_dir, 'compile_commands.json')
        xml_report = os.path.join(self.build_dir, 'cppcheck.xml')
        with open(xml_report, "w") as output_file:
            subprocess.Popen(
                [
                    'cppcheck',
                    '--enable=warning,performance,portability,information,missingInclude',
                    '--cppcheck-build-dir=%s' % self.build_dir,
                    '--project=%s' % build_path,
                    '-i',
                    self.deps_cpp_info.includedirs[0],
                    '--quiet',
                    '--xml',
                    '--output-file=%s' % xml_report
                ],
                stderr=subprocess.PIPE
            )
