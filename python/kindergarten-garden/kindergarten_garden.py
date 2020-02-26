class Garden:
    PLANTS = {"G": "Grass", "C": "Clover", "R": "Radishes", "V": "Violets"}

    STUDENTS = [
        "Alice",
        "Bob",
        "Charlie",
        "David",
        "Eve",
        "Fred",
        "Ginny",
        "Harriet",
        "Ileana",
        "Joseph",
        "Kincaid",
        "Larry",
    ]

    def __init__(self, diagram, students=STUDENTS):
        self.assigned_plants = dict(zip(sorted(students), self.plant_groups(diagram)))

    def plants(self, student):
        return [self.PLANTS[plant] for plant in self.assigned_plants[student]]

    def plant_groups(self, rows):
        first_row, second_row = rows.split()
        for start in range(0, len(first_row), 2):
            yield first_row[start : start + 2] + second_row[start : start + 2]
