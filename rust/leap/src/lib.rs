pub fn is_leap_year(year: u64) -> bool {
  match year {
    year if year.divisible_by(400) => true,
    year if year.divisible_by(100) => false,
    year if year.divisible_by(4) => true,
    _ => false
  }
}

trait Divisible<T> {
  fn divisible_by(self, divisor: T) -> bool;
}

impl Divisible<u64> for u64 {
  fn divisible_by(self: u64, divisor: u64) -> bool {
    self % divisor == 0
  }
}
