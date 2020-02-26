def recite(start_verse, end_verse):
    return [_verse_text(verse) for verse in range(start_verse, end_verse + 1)]


def _verse_text(verse):
    return _intro(verse) + _gifts(verse)


def _intro(verse):
    return f"On the {_to_ordinal(verse)} day of Christmas my true love gave to me: "


def _to_ordinal(verse):
    return {
        1: "first",
        2: "second",
        3: "third",
        4: "fourth",
        5: "fifth",
        6: "sixth",
        7: "seventh",
        8: "eighth",
        9: "ninth",
        10: "tenth",
        11: "eleventh",
        12: "twelfth",
    }[verse]


def _gifts(verse):
    if verse == 1:
        return "a Partridge in a Pear Tree."

    return ", ".join(_all_gifts()[_first_gift_for_verse(verse) :])


def _all_gifts():
    return [
        "twelve Drummers Drumming",
        "eleven Pipers Piping",
        "ten Lords-a-Leaping",
        "nine Ladies Dancing",
        "eight Maids-a-Milking",
        "seven Swans-a-Swimming",
        "six Geese-a-Laying",
        "five Gold Rings",
        "four Calling Birds",
        "three French Hens",
        "two Turtle Doves",
        "and a Partridge in a Pear Tree.",
    ]


def _first_gift_for_verse(verse):
    return 12 - verse
