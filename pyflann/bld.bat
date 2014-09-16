cd %SRC_DIR%\src\python

%PYTHON% setup.py install
if errorlevel 1 exit 1
