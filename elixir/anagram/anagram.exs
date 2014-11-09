defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    candidates |> Enum.filter(&anagram_of?(&1, base))
  end

  defp anagram_of?(candidate, word) do
    word_letters = tokens(word)
    candidate_letters = tokens(candidate)

    (word_letters |> differs_from? candidate_letters) and (word_letters |> comprised_of? candidate_letters)
  end

  defp tokens(string) do
    string |> String.downcase |> String.graphemes
  end

  defp differs_from?(left, right) do
    left != right
  end

  defp comprised_of?(left, right) do
    Enum.sort(left) === Enum.sort(right)
  end
end
