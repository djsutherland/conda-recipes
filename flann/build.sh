#!/bin/bash
mkdir build
cd build
export CC=gcc-4.8
export LD=gcc-4.8
export CXX=g++-4.8
cmake .. -DCMAKE_INSTALL_PREFIX=$PREFIX \
         -DBUILD_MATLAB_BINDINGS:BOOL=OFF \
         -DBUILD_PYTHON_BINDINGS:BOOL=ON \
         -DBUILD_EXAMPLES:BOOL=OFF
# TODO: make python bindings work
make -j$(python -c 'import multiprocessing as m; print m.cpu_count()') install
