#!/bin/bash

export PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig
$PYTHON setup.py install
