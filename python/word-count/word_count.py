import re
from collections import Counter

WORD_PATTERN = re.compile(
    r"""
  \w+'?\w+  # two or more word characters with an optional, nested apostrophe
  |         # OR
  \w{1}     # a single word character
""",
    re.VERBOSE,
)


def count_words(sentence):
    return Counter(_to_words(sentence))


def _to_words(string):
    return re.findall(WORD_PATTERN, string.lower().replace("_", " "))
