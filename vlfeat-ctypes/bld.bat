"%PYTHON%" setup.py install
"%PYTHON%" -m vlfeat.download
if errorlevel 1 exit 1
