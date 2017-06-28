set -e

mkdir build
cd build

if [[ $(uname) == "Darwin" ]]; then
    pylib=$(otool -L $PYTHON | grep 'libpython.*\.so' | tr '\t' ' ' | cut -d' ' -f2 | sed "s|@rpath|$PREFIX|")
else
    pylib=$(ldd $PYTHON | grep $PREFIX | grep 'libpython.*\.so' | cut -d' ' -f3)
fi

cmake .. \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_EXAMPLES=OFF \
    -DBUILD_META_EXAMPLES=OFF \
    -DBUNDLE_JSON=OFF \
    -DBUNDLE_NLOPT=OFF \
    -DENABLE_TESTING=OFF \
    -DENABLE_COVERAGE=OFF \
    -DENABLE_APRACK=OFF \
    -DENABLE_LZO=OFF \
    -DSWIG_EXECUTABLE=$PREFIX/bin/swig \
    -DPYTHON_INCLUDE_DIR=$($PYTHON -c "from distutils import sysconfig; print(sysconfig.get_python_inc())") \
    -DPYTHON_LIBRARY=$pylib \
    -DPYTHON_EXECUTABLE=$PYTHON \
    -DPythonModular=ON

make install
