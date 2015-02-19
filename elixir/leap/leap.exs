defmodule Year do
  defmacro divisible_by?(year, number) do
    quote do
      rem(unquote(year), unquote(number)) == 0
    end
  end

  @doc """
  Returns whether 'year' is a leap year.

  A leap year occurs:

  on every year that is evenly divisible by 4
    except every year that is evenly divisible by 100
      except every year that is evenly divisible by 400.
  """
  @spec leap_year?(integer) :: boolean
  def leap_year?(year) when year |> divisible_by?(400), do: true
  def leap_year?(year) when year |> divisible_by?(100), do: false
  def leap_year?(year), do: year |> divisible_by?(4)
end
