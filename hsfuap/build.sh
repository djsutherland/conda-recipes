#!/bin/bash

HSFUAP_DIR=${HSFUAP_DIR:-$HOME/hsfuap}

date -d "$(git --git-dir=$HSFUAP_DIR/.git log -n1 --format=%ci)" +0.1.0dev%Y.%m.%d.%H.%M > __conda_version__.txt

cp -a $HSFUAP_DIR/* .
$PYTHON setup.py install
