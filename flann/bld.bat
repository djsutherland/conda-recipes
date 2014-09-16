mkdir build
cd build

REM set up visual studio
set MSVC_VERSION=12.0
set CMAKEGEN=Visual Studio 12 2013 Win64
if "%PROGRAMFILES(X86)%" == "" set VCDIR=%PROGRAMFILES%\Microsoft Visual Studio  %MSVC_VERSION%\VC
if NOT "%PROGRAMFILES(X86)%" == "" set VCDIR=%PROGRAMFILES(X86)%\Microsoft Visual Studio %MSVC_VERSION%\VC
call "%VCDIR%\vcvarsall.bat"
IF %ERRORLEVEL% NEQ 0 exit /b 1

REM configure
cmake -G "%CMAKEGEN%" -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX%  -DCMAKE_INSTALL_PREFIX:PATH=%LIBRARY_PREFIX% -DBUILD_MATLAB_BINDINGS:BOOL=OFF -DBUILD_PYTHON_BINDINGS:BOOL=OFF -DBUILD_EXAMPLES:BOOL=OFF -DBUILD_TESTS:BOOL=OFF -DBUILD_DOC:BOOL=OFF %SRC_DIR%
if errorlevel 1 exit /b 1

REM install
cmake --build . --target install --config Release
if errorlevel 1 exit /b 1
