#!/bin/bash

# TODO: add logic here
if [[ `uname` == Darwin ]]; then
    export CC=gcc-4.8
    export LD=gcc-4.8
    export CXX=g++-4.8
fi

# TODO: any way to just add to include dirs?
npy_i=$($PYTHON -c 'import numpy; print(numpy.get_include())')
$PYTHON setup.py build build_ext -I $npy_i:$PREFIX/include
$PYTHON setup.py install
