#!/bin/bash

if [[ `uname` == Darwin ]]; then
    export CC=gcc-4.9
    export LD=gcc-4.9
    export CXX=g++-4.9
fi

HSFUAP_DIR=$RECIPE_DIR/src

date="$(git --git-dir=$HSFUAP_DIR/.git log -n1 --format=%ct)"
$PYTHON -c "import datetime; print('0.1.0dev{:%Y.%m.%d.%H.%M}'.format(datetime.datetime.fromtimestamp($date)))" > __conda_version__.txt

cp -a $HSFUAP_DIR/* .
$PYTHON setup.py install
