mkdir build
cd build

REM set up visual studio
set MSVC_VERSION=12.0
if "%PROGRAMFILES(X86)%" == "" set VCDIR=%PROGRAMFILES%\Microsoft Visual Studio  %MSVC_VERSION%\VC
if NOT "%PROGRAMFILES(X86)%" == "" set VCDIR=%PROGRAMFILES(X86)%\Microsoft Visual Studio %MSVC_VERSION%\VC
call "%VCDIR%\vcvarsall.bat" %MSVC_VCVARS_PLATFORM%
IF %ERRORLEVEL% NEQ 0 exit /b 1

REM configure
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX%  -DCMAKE_INSTALL_PREFIX:PATH=%LIBRARY_PREFIX% -DBUILD_MATLAB_BINDINGS:BOOL=OFF -DBUILD_PYTHON_BINDINGS:BOOL=OFF -DBUILD_EXAMPLES:BOOL=OFF -DBUILD_TESTS:BOOL=OFF -DBUILD_DOC:BOOL=OFF %SRC_DIR%
if errorlevel 1 exit /b 1

echo %RELEASE_TARGET%
REM build
devenv %PKG_NAME%.sln /Build "%RELEASE_TARGET%"
if errorlevel 1 exit /b 1

REM install
devenv %PKG_NAME%.sln /Build "%RELEASE_TARGET%" /Project INSTALL
if errorlevel 1 exit /b 1
