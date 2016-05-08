defmodule Acronym do
  @whitespace_or_before_capital_letter ~r/\s+|.(?=\p{Lu})/

  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t) :: String.t
  def abbreviate(string) do
    string
    |> String.split(@whitespace_or_before_capital_letter)
    |> Enum.map(&upcase_first_letter(&1))
    |> Enum.join
  end

  defp upcase_first_letter(word) do
    word
    |> String.slice(0, 1)
    |> String.upcase
  end
end
