#!/bin/bash

if [[ `uname` == Darwin ]]; then
    # make sure we're using anaconda's gcc for requirements
    export CC=gcc
    export LD=gcc
    export CXX=g++
fi

# TODO: any way to just add to include dirs?
npy_i=$($PYTHON -c 'import numpy; print(numpy.get_include())')
$PYTHON setup.py build build_ext -I $npy_i:$PREFIX/include
$PYTHON setup.py install
