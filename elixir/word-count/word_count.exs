defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map()
  def count(sentence) do
    sentence
      |> replace_punctuation
      |> ignore_case
      |> split_into_words
      |> count_words
  end

  defp replace_punctuation(string, replacement \\ " ") do
    Regex.replace(~r/[^\w-]|_/u, string, replacement)
  end

  defp ignore_case(string) do
    String.downcase(string)
  end

  defp split_into_words(string) do
    String.split(string)
  end

  defp count_words(words) do
    Enum.reduce(words, %{}, &count_word/2)
  end

  defp count_word(word, map) do
    Map.put(map, word, Map.get(map, word, 0) + 1)
  end
end
