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
    |> String.to_char_list
    |> trim_us_country_code
    |> clear_invalid
    |> List.to_string
  end

  defp clean(raw) do
    String.replace raw, ~r/\D/, ""
  end

  defp trim_us_country_code(list) when length(list) == 11 do
    if hd(list) == ?1, do: tl(list), else: list
  end
  defp trim_us_country_code(list), do: list

  defp clear_invalid(cleaned) when length(cleaned) == 10, do: cleaned
  defp clear_invalid(_), do: cleared_number

  defp cleared_number do
    '0000000000'
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
    |> String.to_char_list
    |> trim_us_country_code
    |> List.to_string
    |> String.slice(0, 3)
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
    |> String.to_char_list
    |> trim_us_country_code
    |> List.to_string
    |> split
    |> assemble
  end

  defp split(cleaned) do
    {
      String.slice(cleaned, 0..2),
      String.slice(cleaned, 3..5),
      String.slice(cleaned, 6..9)
    }
  end

  defp assemble({area, first, last}) do
    "(#{area}) #{first}-#{last}"
  end
end
