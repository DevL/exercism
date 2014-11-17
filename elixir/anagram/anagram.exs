defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    Enum.map(candidates, &process(&1, base, self))
    |> Enum.flat_map(&receive_result(&1))
  end

  defp process(candidate, base, collector) do
    spawn_link(fn -> anagram(candidate, base, collector) end)
  end

  def receive_result(pid) do
    receive do
      {:anagram, ^pid, anagram} -> [anagram]
      {:not_anagram, ^pid} -> []
    end
  end

  defp anagram(candidate, word, collector) do
    if anagram_of?(candidate, word) do
      send collector, {:anagram, self, candidate}
    else
      send collector, {:not_anagram, self}
    end
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
