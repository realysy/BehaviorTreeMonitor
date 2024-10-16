#!/bin/bash
build_type=Debug  # Debug, RelWithDebInfo, Release
abi=x64

cd ../
mkdir -p bin_$abi

if [ ! -d "build_$abi" ]; then
    mkdir build_$abi
fi
cd build_$abi
# make clean

cmake -G "Unix Makefiles" \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_BUILD_TYPE=$build_type \
    ../

make -j12
cp BTMonitor ../bin_$abi/

cd ../scripts
bash run.sh
