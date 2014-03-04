#!/bin/bash

mkdir build
cd build

# TODO: add logic here...
if [[ `uname` == Darwin ]]; then
    export CC=gcc-4.8
    export LD=gcc-4.8
    export CXX=g++-4.8
fi

cmake .. -DCMAKE_INSTALL_PREFIX=$PREFIX \
         -DBUILD_MATLAB_BINDINGS:BOOL=OFF \
         -DBUILD_PYTHON_BINDINGS:BOOL=ON \
         -DBUILD_EXAMPLES:BOOL=OFF

make -j$(python -c 'import multiprocessing as m; print m.cpu_count()') install

if [[ `uname` == Darwin ]]; then
    # copy in the gcc-4.8 version of openmp, etc
    # TODO: solve this a better way.
    cd $PREFIX/lib

    libgomp=$(otool -L libflann.dylib | grep -Eo '/.*libgomp.*?\s')
    libstd=$(otool -L libflann.dylib | grep -Eo '/.*libstdc\+\+.*?\s')
    libgcc=$(otool -L libflann.dylib | grep -Eo '/.*libgcc_s.*?\s' \
             | grep -v '^\s*/usr/lib/libgcc_s')

    lgomp=flann-support_$(basename $libgomp)
    lstd=flann-support_$(basename $libstd)
    lgcc=flann-support_$(basename $libgcc)

    cp $libgomp $lgomp
    cp $libstd $lstd
    cp $libgcc $lgcc
    chmod u+w $lgomp $lstd $lgcc

    for x in libflann.dylib libflann_cpp.dylib $lgomp $lstd $lgcc; do
        install_name_tool -id $PREFIX/lib/$x $x
        install_name_tool -change $libgomp $PREFIX/lib/$lgomp $x
        install_name_tool -change $libstd  $PREFIX/lib/$lstd $x
        install_name_tool -change $libgcc  $PREFIX/lib/$lgcc $x
    done

    cd -
fi
