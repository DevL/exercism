defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  defmacro any_not_positive?(a, b, c) do
    quote do
      unquote(a) <= 0 or unquote(b) <= 0 or unquote(c) <= 0
    end
  end

  defmacro violating_triangle_rule?(a, b, c) do
    quote do
      unquote(a) + unquote(b) <= unquote(c) or
        unquote(b) + unquote(c) <= unquote(a) or
        unquote(c) + unquote(a) <= unquote(b)
    end
  end

  defmacro all_different?(a, b, c) do
    quote do
      unquote(a) != unquote(b) and
        unquote(b) != unquote(c) and
        unquote(c) != unquote(a)
    end
  end

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: { :ok, kind } | { :error, String.t }
  def kind(a, b, c) when any_not_positive?(a, b, c), do: not_positive_error
  def kind(a, b, c) when violating_triangle_rule?(a, b, c), do: violating_triangle_rule_error

  def kind(same, same, same), do: { :ok, :equilateral }
  def kind(a, b, c) when all_different?(a, b, c), do: { :ok, :scalene }
  def kind(_, _, _), do: { :ok, :isosceles }

  defp not_positive_error, do: { :error, "all side lengths must be positive" }
  defp violating_triangle_rule_error, do: { :error, "side lengths violate triangle inequality" }
end
