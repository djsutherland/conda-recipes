set -e

mkdir build
cd build

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
    -DPYTHON_INCLUDE_DIR=$($PYTHON -c "from distutils import sysconfig; print(sysconfig.get_python_inc())") \
    -DPYTHON_LIBRARY=$(echo $PREFIX/lib/libpython$PY_VER*) \
    -DPYTHON_EXECUTABLE=$PYTHON \
    -DPythonModular=ON

make install
