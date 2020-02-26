from random import randint


def modifier(attribute_value):
    return (attribute_value - 10) // 2


class Character:
    def __init__(self):
        self.strength = self.ability()
        self.dexterity = self.ability()
        self.constitution = self.ability()
        self.intelligence = self.ability()
        self.wisdom = self.ability()
        self.charisma = self.ability()
        self.hitpoints = self.hitpoints()

    def ability(self):
        return sum(self.three_highest_of_4d6())

    def hitpoints(self):
        return 10 + modifier(self.constitution)

    def three_highest_of_4d6(self):
        return sorted([randint(1, 6) for _ in range(4)])[1:]
