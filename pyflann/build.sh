# replace the setup.py file
# we don't want to copy in the flann library, just find it normally
# it'll work anyway, because load_flann_library() will look in all the parents of
#   /path/to/env/lib/python2.7/site-packages/pyflann/lib/
# including /path/to/env/lib, which is where it is.
# it'd import slightly faster if we replaced that code, though....

cd $SRC_DIR/src/python

cat << EOF > setup.py
#!/usr/bin/env python2

from distutils.core import setup

# removed find_path() stuff, don't need it

setup(name='flann',
      version='$PKG_VERSION',
      description='Fast Library for Approximate Nearest Neighbors',
      author='Marius Muja',
      author_email='mariusm@cs.ubc.ca',
      license='BSD',
      url='http://www.cs.ubc.ca/~mariusm/flann/',
      packages=['pyflann'],
)
EOF

$PYTHON setup.py install
