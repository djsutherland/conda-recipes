#!/bin/bash

if [[ `uname` == Darwin ]]; then
    export CC=gcc-4.9
    export LD=gcc-4.9
    export CXX=g++-4.9
fi

$PYTHON setup.py install
$PYTHON setup_accel.py install

if [[ `uname` == Darwin ]]; then
    # use the flann-support version of gomp, etc
    # TODO: solve this a better way.
    cd $PREFIX/lib/python$PY_VER/site-packages/skl_groups_accel*/skl_groups_accel

    libgomp=$(otool -L knn_divs.so | grep -Eo '/.*libgomp.*?\s')
    libgcc=$(otool -L knn_divs.so | grep -Eo '/.*libgcc_s.*?\s' \
             | grep -v '^\s*/usr/lib/libgcc_s')

    lgomp=flann-support_$(basename $libgomp)
    lgcc=flann-support_$(basename $libgcc)

    # for x in libflann.dylib libflann_cpp.dylib $lgomp $lstd $lgcc; do
        # install_name_tool -id $PREFIX/lib/$x $x
    install_name_tool -change libflann.dylib $PREFIX/lib/libflann.dylib knn_divs.so
    install_name_tool -change $libgomp $PREFIX/lib/$lgomp knn_divs.so
    install_name_tool -change $libgcc  $PREFIX/lib/$lgcc  knn_divs.so

    cd -
fi
