class Matrix:
    def __init__(self, matrix_string):
        self.rows = [self._convert(row) for row in matrix_string.split("\n")]

    def row(self, index):
        return self.rows[index - 1]

    def column(self, index):
        return [row[index - 1] for row in self.rows]

    @staticmethod
    def _convert(row_string):
        return [int(number) for number in row_string.split()]
