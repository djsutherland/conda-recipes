#!/bin/bash

# TODO: add logic here
if [[ `uname` == Darwin ]]; then
    export CC=gcc
    export LD=gcc
    export CXX=g++
fi

# TODO: any way to just add to include dirs?
npy_i=$($PYTHON -c 'import numpy; print(numpy.get_include())')
$PYTHON setup.py build build_ext -I $npy_i:$PREFIX/include
$PYTHON setup.py install

if [[ `uname` == Darwin ]]; then
    # use the flann-support version of gomp, etc
    # TODO: solve this a better way.
    cd $PREFIX/lib/python$PY_VER/site-packages/py_sdm-*.egg/sdm

    libgomp=$(otool -L _np_divs_cy.so | grep -Eo '/.*libgomp.*?\s')
    libgcc=$(otool -L _np_divs_cy.so | grep -Eo '/.*libgcc_s.*?\s' \
             | grep -v '^\s*/usr/lib/libgcc_s')

    lgomp=flann-support_$(basename $libgomp)
    lgcc=flann-support_$(basename $libgcc)

    # for x in libflann.dylib libflann_cpp.dylib $lgomp $lstd $lgcc; do
        # install_name_tool -id $PREFIX/lib/$x $x
    install_name_tool -change libflann.dylib $PREFIX/lib/libflann.dylib _np_divs_cy.so
    install_name_tool -change $libgomp $PREFIX/lib/$lgomp _np_divs_cy.so
    install_name_tool -change $libgcc  $PREFIX/lib/$lgcc  _np_divs_cy.so

    cd -
fi