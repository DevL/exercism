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
    |> EnumUtils.count_occurances
  end

  defp split_into_countable_words(string) do
    string
    |> String.downcase
    |> String.split(@word_delimiter_pattern, trim: true)
  end
end

defmodule EnumUtils do
  def count_occurances(values) do
    Enum.reduce(values, %{}, &count_occurance/2)
  end

  defp count_occurance(value, occurrences) do
    Map.put(occurrences, value, next_count(occurrences, value))
  end

  defp next_count(occurrences, value) do
    Map.get(occurrences, value, 0) + 1
  end
end
