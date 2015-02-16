defmodule Roman do
  @roman_numerals %{
    1 => "I", 4 => "IV", 5 => "V", 9 => "IX", 10 => "X", 40 => "XL", 50 => "L",
    90 => "XC", 100 => "C", 400 => "CD", 500 => "D", 900 => "CM", 1000 => "M"
  }

  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(number) do
    numerals(number, "")
  end

  defp numerals(0, result), do: result
  defp numerals(number, result) do
    largest = largest(number)
    numerals(number - largest, result <> @roman_numerals[largest])
  end

  defp largest(number) do
    @roman_numerals
    |> Dict.keys
    |> Enum.take_while(&equal_or_less_than &1, number)
    |> Enum.max
  end

  defp equal_or_less_than(key, number), do: key <= number
end
