defmodule DNA do
  @transcription_rules %{ ?G => ?C, ?C => ?G, ?T => ?A, ?A => ?U }

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

  defp transcribe(nucleotide) do
    @transcription_rules |> Map.get nucleotide
  end
end
