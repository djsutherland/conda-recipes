#!/bin/bash

mkdir build
cd build

if [[ `uname` == Darwin ]]; then
    # Make sure we're using conda gcc
    export CC=gcc
    export LD=gcc
    export CXX=g++
fi

cmake .. -DCMAKE_INSTALL_PREFIX=$PREFIX \
         -DBUILD_MATLAB_BINDINGS:BOOL=OFF \
         -DBUILD_PYTHON_BINDINGS:BOOL=OFF \
         -DBUILD_EXAMPLES:BOOL=OFF

make -j$(python -c 'import multiprocessing as m; print m.cpu_count()') install
