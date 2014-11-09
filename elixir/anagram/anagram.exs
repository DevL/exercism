defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    candidates |> Enum.filter(&anagram_of?(&1, base))
  end

  defp anagram_of?(candidate, word) do
    word_tokens = tokens(word)
    candidate_tokens = tokens(candidate)

    differs?(word_tokens, candidate_tokens) and has_same_constituents?(word_tokens, candidate_tokens)
  end

  defp tokens(string) do
    string |> String.downcase |> String.graphemes
  end

  defp differs?(left, right) do
    left != right
  end

  defp has_same_constituents?(left, right) do
    Enum.sort(left) === Enum.sort(right)
  end
end
