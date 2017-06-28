setlocal EnableDelayedExpansion

mkdir build
cd build

FOR /F "tokens=* USEBACKQ" %%F IN (`%PYTHON% -c "from distutils import sysconfig; print(sysconfig.get_python_inc())"`) DO (
SET PY_INCLUDE=%%F
)

%LIBRARY_BIN%\cmake .. ^
    -G"%CMAKE_GENERATOR%" ^
    -DCMAKE_PREFIX_PATH="%PREFIX%" ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DBUILD_EXAMPLES=OFF ^
    -DBUILD_META_EXAMPLES=OFF ^
    -DBUNDLE_JSON=OFF ^
    -DBUNDLE_NLOPT=OFF ^
    -DENABLE_TESTING=OFF ^
    -DENABLE_COVERAGE=OFF ^
    -DENABLE_LZO=OFF ^
    -DPYTHON_INCLUDE_DIR="%PY_INCLUDE%" ^
    -DPYTHON_LIBRARY="%LIBRARY_PREFIX/libpython%PY_VER%.dll" ^
    -DPYTHON_EXECUTABLE="%PYTHON%" ^
    -DPythonModular=ON
if errorlevel 1 exit 1

msbuild shogun.sln /verbosity:minimal /t:Clean /p:Configuration=Release /p:Platform=x64
