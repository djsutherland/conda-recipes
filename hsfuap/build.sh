#!/bin/bash

if [[ `uname` == Darwin ]]; then
    export CC=gcc-4.9
    export LD=gcc-4.9
    export CXX=g++-4.9
fi

$PYTHON setup.py egg_info
sed -n -e 's/^Version: \(.*\)$/\1/p' < hsfuap.egg-info/PKG-INFO > __conda_version__.txt

$PYTHON setup.py install
