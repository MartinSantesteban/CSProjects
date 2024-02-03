import unittest

class TestBasic(unittest.TestCase):
    def test_hello_world(self):
        self.assertFalse('hello' == 'world')

    def test_world(self):
        self.assertEqual('world', 'world')

if __name__ == '__main__':
    unittest.main()