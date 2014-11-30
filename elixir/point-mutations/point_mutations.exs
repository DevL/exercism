defmodule DNA do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> DNA.hamming_distance('AAGTCATA', 'TAGCGATC')
  4
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(left, right) when length(left) == length(right) do
    hamming_distance(left, right, 0)
  end
  def hamming_distance(_, _), do: nil

  defp hamming_distance([], [], acc), do: acc
  defp hamming_distance([head|left_tail], [head|right_tail], acc) do
    hamming_distance(left_tail, right_tail, acc)
  end
  defp hamming_distance(left, right, acc) do
    hamming_distance(tl(left), tl(right), acc + 1)
  end
end
