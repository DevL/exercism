def convert(number):
    return combine(raindrops_for(number)) or str(number)


def combine(list):
    return "".join(list)


def raindrops_for(number):
    return [
        raindrop
        for factor, raindrop in factor_to_raindrop()
        if devisable(number, factor)
    ]


def factor_to_raindrop():
    return {3: "Pling", 5: "Plang", 7: "Plong"}.items()


def devisable(number, factor):
    return number % factor == 0
