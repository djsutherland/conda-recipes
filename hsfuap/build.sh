#!/bin/bash

$PYTHON setup.py egg_info
sed -n -e 's/^Version: \(.*\)$/\1/p' < hsfuap.egg-info/PKG-INFO > __conda_version__.txt

$PYTHON setup.py install
