# copied from the typedbytes-0.3.8 source
# because conda isn't great about this testing case
import cStringIO
import unittest
import time
import typedbytes
from itertools import imap


class TestSpeed(unittest.TestCase):

    def testints(self):
        file = cStringIO.StringIO()

        output = typedbytes.Output(file)
        t = time.time()
        output.writes(xrange(100000))
        print time.time() - t

        file.seek(0)

        input = typedbytes.Input(file)
        t = time.time()
        for record in input:
            pass
        print time.time() -t

        file.close()

    def teststrings(self):
        file = cStringIO.StringIO()

        output = typedbytes.Output(file)
        t = time.time()
        output.writes(imap(str, xrange(100000)))
        print time.time() - t

        file.seek(0)

        input = typedbytes.Input(file)
        t = time.time()
        for record in input:
            pass
        print time.time() -t

        file.close()

    def testunicodes(self):
        file = cStringIO.StringIO()

        output = typedbytes.Output(file)
        t = time.time()
        output.writes(imap(unicode, xrange(100000)))
        print time.time() - t

        file.seek(0)

        input = typedbytes.Input(file)
        t = time.time()
        for record in input:
            pass
        print time.time() -t

        file.close()


if __name__ == "__main__":
    suite = unittest.TestLoader().loadTestsFromTestCase(TestSpeed)
    unittest.TextTestRunner(verbosity=2).run(suite)
