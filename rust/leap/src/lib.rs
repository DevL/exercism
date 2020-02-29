pub fn is_leap_year(year: u64) -> bool {
  match year {
    year if divisible_by(&year, 400) => true,
    year if divisible_by(&year, 100) => false,
    year if divisible_by(&year, 4) => true,
    _ => false
  }
}

fn divisible_by(year: &u64, divisor: u64) -> bool {
  year % divisor == 0
}
