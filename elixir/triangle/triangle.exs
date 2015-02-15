defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: { :ok, kind } | { :error, String.t }
  def kind(a, b, c) do
    cond do
      any_negative?(a, b, c) -> not_positive_error
      violating_triangle_rule?(a, b, c) -> violating_triangle_rule_error
      all_equal?(a, b, c) -> { :ok, :equilateral }
      all_different?(a, b, c) -> { :ok, :scalene }
      true -> { :ok, :isosceles }
    end
  end

  defp all_equal?(same, same, same), do: true
  defp all_equal?(_, _, _), do: false

  defp all_different?(a, b, c) do
    Enum.uniq([a, b, c]) == [a, b, c]
  end

  defp any_negative?(a, b, c) do
    Enum.any? [a, b, c], fn(x) -> x <= 0 end
  end

  def violating_triangle_rule?(a, b, c) do
    {smallest_pair, max} = sort_and_split(a, b, c)
    Enum.sum(smallest_pair) <= hd(max)
  end

  defp sort_and_split(a, b, c) do
    [a, b, c]
    |> Enum.sort
    |> Enum.split 2
  end

  defp not_positive_error, do: { :error, "all side lengths must be positive" }
  defp violating_triangle_rule_error, do: { :error, "side lengths violate triangle inequality" }
end
