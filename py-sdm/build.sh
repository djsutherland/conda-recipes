#!/bin/bash

# TODO: add logic here
if [[ `uname` == Darwin ]]; then
    export CC=gcc-4.8
    export LD=gcc-4.8
    export CXX=g++-4.8
fi

$PYTHON setup.py install
