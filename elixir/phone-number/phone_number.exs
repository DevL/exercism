defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("123-456-7890")
  "1234567890"

  iex> Phone.number("+1 (303) 555-1212")
  "3035551212"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) do
    raw
    |> clean
    |> normalise
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("123-456-7890")
  "123"

  iex> Phone.area_code("+1 (303) 555-1212")
  "303"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    raw
    |> normalise
    |> extract_area_code
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("123-456-7890")
  "(123) 456-7890"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    raw
    |> normalise
    |> split
    |> assemble
  end

  defp assemble({area, exchange, subscriber}) do
    "(#{area}) #{exchange}-#{subscriber}"
  end

  defp clean(raw) do
    String.replace raw, ~r/\D/, ""
  end

  defp cleared_number do
    "0000000000"
  end

  defp extract_area_code(normalised_number) do
    normalised_number |> String.slice(0..2)
  end

  defp extract_exchange(normalised_number) do
    normalised_number |> String.slice(3..5)
  end

  defp extract_subscriber(normalised_number) do
    normalised_number |> String.slice(6..9)
  end

  defp normalise(normal_number) when byte_size(normal_number) == 10, do: normal_number
  defp normalise(<<?1, trimmed_number :: binary>>) when byte_size(trimmed_number) == 10, do: trimmed_number
  defp normalise(_), do: cleared_number

  defp split(normalised_number) do
    {
      extract_area_code(normalised_number),
      extract_exchange(normalised_number),
      extract_subscriber(normalised_number)
    }
  end
end
