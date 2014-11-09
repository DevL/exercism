defmodule Words do
  @word_delimiter_pattern ~r/[^\w-]|_/u

  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map()
  def count(sentence) do
    sentence
    |> split_into_countable_words
    |> count_words
  end

  defp split_into_countable_words(string) do
    string
    |> String.downcase
    |> String.split(@word_delimiter_pattern, trim: true)
  end

  defp count_words(words) do
    Enum.reduce(words, %{}, &count_word/2)
  end

  defp count_word(word, dictionary) do
    Map.put(dictionary, word, next_count(dictionary, word))
  end

  defp next_count(dictionary, word) do
    Map.get(dictionary, word, 0) + 1
  end
end
