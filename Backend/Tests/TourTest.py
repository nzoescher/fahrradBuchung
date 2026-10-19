import unittest
from datetime import datetime, timedelta

from Backend.models import Tour


class MyTestCase(unittest.TestCase):
    def test_something(self):

        tour = Tour("TestTour", datetime.now()+ timedelta(seconds=50), datetime.now()+ timedelta(seconds=10))
        self.assertRaises(ValueError)
        self.assertEqual(True, False)  # add assertion here


if __name__ == '__main__':
    unittest.main()
