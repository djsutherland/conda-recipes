set FLANN_DIR="%PREFIX%"
"%PYTHON%" setup.py install
if errorlevel 1 exit 1
