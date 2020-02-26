def leap_year(year):
    return basic_rule(year) and any(
        special_rule(year) for special_rule in [not_centennial, quadcentennial]
    )


def basic_rule(year):
    return divisible(year, 4)


def not_centennial(year):
    return not divisible(year, 100)


def quadcentennial(year):
    return divisible(year, 400)


def divisible(year, divisor):
    return year % divisor == 0
