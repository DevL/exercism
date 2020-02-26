def is_isogram(string):
    normalized = _normalize(string)
    return len(_to_filtered_set(normalized)) == len(normalized)


def _normalize(string):
    # return [letter for letter in string.lower() if letter.isalpha()]
    translations = str.maketrans("", "", " -_")
    return string.translate(translations).lower()


def _to_filtered_set(string):
    return set(list(string))
