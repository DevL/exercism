defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: { :ok, kind } | { :error, String.t }
  def kind(a, b, c) when a <= 0 or b <= 0 or c <= 0, do: not_positive_error
  def kind(a, b, c) when a + b <= c or b + c <= a or c + a <= b, do: violating_tringle_rule_error
  def kind(same, same, same), do: { :ok, :equilateral }
  def kind(a, b, c) when a != b and b != c and c != a, do: { :ok, :scalene }
  def kind(_, _, _), do: { :ok, :isosceles }

  defp not_positive_error, do: { :error, "all side lengths must be positive" }
  defp violating_tringle_rule_error, do: { :error, "side lengths violate triangle inequality" }
end
