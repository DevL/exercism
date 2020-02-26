def distance(strand_a, strand_b):
    _ensure_equal_length(strand_a, strand_b)
    return len(_difference(strand_a, strand_b))


def _difference(strand_a, strand_b):
    return [
        nucleobase
        for position, nucleobase in enumerate(strand_a)
        if nucleobase != strand_b[position]
    ]


def _ensure_equal_length(strand_a, strand_b):
    if not len(strand_a) == len(strand_b):
        raise ValueError("The strands are of different lengths.")
