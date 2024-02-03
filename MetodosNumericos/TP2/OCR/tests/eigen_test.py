import sys
import unittest
import numpy as np
import build.metnum

class TestEigenvalues(unittest.TestCase):

    def test_diagonal(self):
        A = np.array([[5,0,0],[0,3,0],[0,0,17]])
        (λs, vectors) = build.metnum.get_first_eigenvalues(A, 3)
        for i in range(3):
            self.assertAlmostEqual(λs[i], [17, 5, 3][i])

    def test_triangular(self):
        A = np.array([[34,6,5],[0,99,67],[0,0,17]])
        (λs, vectors) = build.metnum.get_first_eigenvalues(A, 3)
        for i in range(3):
            self.assertAlmostEqual(λs[i], [99, 34, 17][i])

    def test_3x3(self):
        A = np.array([[7,2,3],[0,2,0],[6,-2,-2]])
        (λs, vectors) = build.metnum.get_first_eigenvalues(A, 3)
        for i in range(3):
            self.assertAlmostEqual(λs[i], [8.684658438, -3.684658438, 2][i])

    def test_2x2(self):
        A = np.array([[5,2],[2,8]])
        (λs, vectors) = build.metnum.get_first_eigenvalues(A, 2)
        for i in range(2):
            self.assertAlmostEqual(λs[i], [9,4][i])

    def test_2x2_ld(self):
        A = np.array([[5,5],[5,5]])
        (λs, vectors) = build.metnum.get_first_eigenvalues(A, 2)
        for i in range(2):
            self.assertAlmostEqual(λs[i], [10,0][i])

if __name__ == '__main__':
    unittest.main()