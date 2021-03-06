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
    |> EnumUtils.count_occurrences
  end

  defp split_into_countable_words(string) do
    string
    |> String.downcase
    |> String.split(@word_delimiter_pattern, trim: true)
  end
end

defmodule EnumUtils do
  @doc """
  Count the number of occurrences of identical elements in an enumerable.
  """
  @spec count_occurrences(Enumerable.t) :: map()
  def count_occurrences(enumerable) do
    Enum.reduce(enumerable, %{}, &count_occurrence/2)
  end

  defp count_occurrence(element, occurrences) do
    Map.put(occurrences, element, next_count(occurrences, element))
  end

  defp next_count(occurrences, element) do
    Map.get(occurrences, element, 0) + 1
  end
end
