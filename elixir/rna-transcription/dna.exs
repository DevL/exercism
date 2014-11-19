defmodule DNA do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> DNA.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    dna |> Enum.map(&transcribe(&1))
  end

  defp transcribe(?G), do: ?C
  defp transcribe(?C), do: ?G
  defp transcribe(?T), do: ?A
  defp transcribe(?A), do: ?U
end
