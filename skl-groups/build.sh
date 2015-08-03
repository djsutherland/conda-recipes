#!/bin/bash

if [[ `uname` == Darwin ]]; then
    # make sure we're using the conda-installed GCC
    export CC=gcc
    export LD=gcc
    export CXX=g++
fi

$PYTHON setup.py install
$PYTHON setup_accel.py install
