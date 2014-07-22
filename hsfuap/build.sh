#!/bin/bash

HSFUAP_DIR=${HSFUAP_DIR:-$HOME/hsfuap}
cp -a $HSFUAP_DIR/* .
$PYTHON setup.py install
