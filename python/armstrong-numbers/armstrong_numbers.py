def is_armstrong_number(number):
    digits, exponent = digits_and_exponent(number)
    return candidate_sum(digits, exponent) == number


def digits_and_exponent(number):
    digits = str(number)
    exponent = len(digits)
    return map(int, digits), exponent


def candidate_sum(digits, exponent):
    return sum(digit ** exponent for digit in digits)
