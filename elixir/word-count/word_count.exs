defmodule Words do
  @word_delimiter_pattern ~r/[^\w-]|_/u

  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map()
  def count(sentence) do
    sentence
    |> split_into_words
    |> count_words
  end

  defp split_into_words(string) do
    string
    |> String.downcase
    |> String.split(@word_delimiter_pattern, trim: true)
  end

  defp count_words(words) do
    Enum.reduce(words, %{}, &count_word/2)
  end

  defp count_word(word, map) do
    Map.put(map, word, Map.get(map, word, 0) + 1)
  end
end
