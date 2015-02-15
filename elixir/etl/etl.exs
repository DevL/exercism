defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"]}, "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(Dict.t) :: map()
  def transform(input) do
    Enum.reduce input, %{}, &transform_single_score/2
  end

  defp transform_single_score({score, letters}, map) do
    Enum.reduce letters, map, fn(letter, map) ->
      Dict.put(map, String.downcase(letter), score)
    end
  end
end
