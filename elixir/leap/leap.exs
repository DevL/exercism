defmodule GuardSafe do
  defmacro divisible_by?(number, divisor) do
    quote do
      rem(unquote(number), unquote(divisor)) == 0
    end
  end
end

defmodule Year do
  import GuardSafe, only: [divisible_by?: 2]

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
