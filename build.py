from conan.packager import ConanMultiPackager


if __name__ == "__main__":
    
    builder = ConanMultiPackager(username="madduci", 
                                 gcc_versions=["7"],
                                 clang_versions=["6.0"],
                                 visual_versions=["15"])
    builder.add_common_builds()
    builder.run()
