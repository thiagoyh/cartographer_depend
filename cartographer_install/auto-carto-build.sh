#!/bin/bash

# Install the required libraries that are available as debs.
# sudo apt-get update
sudo apt-get install \
    clang \
    cmake \
    g++ \
    git \
    google-mock \
    libboost-all-dev \
    libcairo2-dev \
    libcurl4-openssl-dev \
    libeigen3-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    liblua5.2-dev \
    libsuitesparse-dev \
    lsb-release \
    ninja-build \
    stow \
    python-wstool \
    python-rosdep \
	python-sphinx \
	libatlas-base-dev



# Build and install abseil-cpp
set -o errexit
set -o verbose

cd abseil-cpp
git checkout d902eb869bcfacc1bad14933ed9af4bed006d481
mkdir build
cd build
cmake -G Ninja \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
  -DCMAKE_INSTALL_PREFIX=/usr/local/stow/absl \
  ..
ninja
sudo ninja install
cd /usr/local/stow
sudo stow absl


# Build and install Ceres.
cd -
cd ../../ceres-solver
mkdir build
cd build
cmake .. -G Ninja -DCXX11=ON
ninja
#CTEST_OUTPUT_ON_FAILURE=1 ninja test
sudo ninja install


# Build and install proto3.
cd ../../protobuf
mkdir build
cd build
cmake -G Ninja \
  -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -Dprotobuf_BUILD_TESTS=OFF \
  ../cmake
ninja
sudo ninja install


# Build and install Cartographer.
cd ../../cartographer
mkdir build
cd build
cmake .. -G Ninja
ninja
#CTEST_OUTPUT_ON_FAILURE=1 ninja test
sudo ninja install


