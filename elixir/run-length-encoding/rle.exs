defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    string
    |> String.graphemes
    |> count_consecutive
  end

  defp count_consecutive(letters), do: count_consecutive(letters, [])

  defp count_consecutive([], counted), do: counted |> :lists.reverse |> Enum.join
  defp count_consecutive([current|rest], counted) do
    {encoded, remaining} = count_current(current, rest)
    count_consecutive(remaining, [encoded|counted])
  end

  defp count_current(current, rest), do: count_current(current, rest, 1)

  defp count_current(current, [current|rest], count), do: count_current(current, rest, count + 1)
  defp count_current(current, rest, count), do: {"#{count}#{current}", rest}

  @spec decode(String.t) :: String.t
  def decode(string) do
    ~r/(\d+)(\p{Lu})+/
    |> Regex.replace(string, &expand/3)
  end

  defp expand(_match, count, letter) do
    expand_group(String.to_integer(count), letter, [])
  end

  defp expand_group(0, _, result), do: Enum.join(result)
  defp expand_group(count, letter, result) do
    expand_group(count - 1, letter, [letter|result])
  end
end
