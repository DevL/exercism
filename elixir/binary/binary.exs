defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal(string) do
    string
    |> normalise
    |> String.reverse
    |> String.split("", trim: true)
    |> Enum.with_index
    |> Enum.map(&convert/1)
    |> Enum.sum
  end

  defp convert({"0", _power}), do: 0
  defp convert({"1", power}), do: :math.pow(2, power)

  defp normalise(string) do
    if valid_binary_number?(string), do: string, else: ""
  end

  defp valid_binary_number?(string) do
    !Regex.match?(~r/[^01]/, string)
  end
end
