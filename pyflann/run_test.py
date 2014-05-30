import numpy as np
import pyflann

idx = pyflann.FLANN()
n = 50
x = np.random.normal(size=(n, 3))

idx, dist = idx.nn(x, x, 2)
assert np.all(idx[:, 0] == np.arange(n))
assert np.all(dist[:, 0] == 0)
assert np.all(dist[:, 1] > 0)
