import re

INITIALS = re.compile(
    r"""
        ^[^\s_-]    # The start of the string that is not whitespace, underscore, or dash.
        |           # OR
        (?<=[\s_-]) # Positive look-behind that is either a whitespace, an underscore, or a dash.
        [^\s_-]     # The first character that is not whitespace, underscore, or dash.
    """,
    re.VERBOSE,
)


def abbreviate(words):
    return "".join(initial.upper() for initial in INITIALS.findall(words))
