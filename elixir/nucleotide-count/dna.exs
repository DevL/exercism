defmodule DNA do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> DNA.count('AATAA', ?A)
  4

  iex> DNA.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count([], _), do: 0
  def count(strand, nucleotide) do
    strand
    |> Enum.reduce(0, &count_matching(&1, nucleotide, &2))
  end

  defp count_matching(nucleotide, nucleotide, sum), do: sum + 1
  defp count_matching(_, _, sum), do: sum

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> DNA.nucleotide_counts('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec nucleotide_counts([char]) :: Dict.t
  def nucleotide_counts(strand) do
    @nucleotides
    |> Enum.map(&process(strand, &1))
    |> Enum.reduce(%{}, &collate(&1, &2))
  end

  defp process(strand, nucleotide) do
    collector = self
    spawn_link fn -> report(collector, strand, nucleotide) end
  end

  defp report(collector, strand, nucleotide) do
    send collector,
      {:nucleotide_count, self, nucleotide, count(strand, nucleotide)}
  end

  defp collate(from, into) do
    receive do
      {:nucleotide_count, ^from, nucleotide, result} ->
        Map.put(into, nucleotide, result)
    end
  end
end
