FROM ubuntu:24.04

# Define Conan and CMake versions
ARG CONAN_VERSION=2.6.0
ARG CMAKE_VERSION=3.30.1

# Define User ID and Group ID
ARG USER_ID=1000
ARG GROUP_ID=1000

WORKDIR /project

# Define Labels
LABEL maintainer="Michele Adduci <adduci@tutanota.com>" \
      description="Docker image for C++ development with Conan and CMake" \
      cmake.version="${CMAKE_VERSION}" \
      conan.version="${CONAN_VERSION}" 

# Install basic tooling
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        curl \
        gcc \
        cppcheck \
        clang-format && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Conan and CMake from GitHub Releases
RUN curl -fsSL https://github.com/conan-io/conan/releases/download/${CONAN_VERSION}/conan-${CONAN_VERSION}-amd64.deb -o /tmp/conan.deb && \
    dpkg -i /tmp/conan.deb && \
    curl -fsSL https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz -o /tmp/cmake.tar.gz && \
    mkdir -p /opt/cmake && \
    tar -xzf /tmp/cmake.tar.gz -C /opt/cmake/ --strip-components=1 && \
    chmod +x /opt/cmake/bin/* && \
    ln -sf /opt/cmake/bin/cmake /usr/bin/cmake && \
    ln -sf /opt/cmake/bin/ctest /usr/bin/ctest && \
    ln -sf /opt/cmake/bin/cpack /usr/bin/cpack && \
    ln -sf /opt/cmake/bin/ccmake /usr/bin/ccmake && \
    rm -rf /tmp/*

# Create non-root user to run container with less privileges
USER ${USER_ID}

# Run Conan profile detection as non-root user
RUN conan profile detect
