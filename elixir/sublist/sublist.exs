defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(left, right) do
    cond do
      left === right -> :equal
      right |> includes? left -> :sublist
      left |> includes? right -> :superlist
      true -> :unequal
    end
  end

  defp includes?([], _), do: false
  defp includes?(left, right) when length(left) < length(right), do: false
  defp includes?(left, right) do
    (left |> starts_with? right) or (tl(left) |> includes? right)
  end

  defp starts_with?(left, right) do
    Enum.take(left, length(right)) === right
  end
end
