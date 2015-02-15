defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"]}, "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(Dict.t) :: map()
  def transform(input) do
    Enum.reduce input, %{}, fn({key, values}, map) ->
      Enum.reduce values, map, fn(value, map) ->
        Dict.put(map, String.downcase(value), key)
      end
    end
  end
end
