defmodule GuardSafe do
  defmacro divisible_by?(number, divisor) do
    quote do
      rem(unquote(number), unquote(divisor)) == 0
    end
  end
end

defmodule PrimeFactors do
  import GuardSafe, only: [divisible_by?: 2]

  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) when number < 1, do: { :error, "prime factors not defined for negative numbers" }
  def factors_for(number) do
    factors_for(number, 2, []) |> Enum.reverse
  end

  defp factors_for(1, _, factors), do: factors
  defp factors_for(number, number, factors), do: [number|factors]
  defp factors_for(number, divisor, factors) when divisible_by?(number, divisor) do
    factors_for(div(number, divisor), 2, [divisor|factors])
  end
  defp factors_for(number, divisor, factors) do
    factors_for(number, divisor + 1, factors)
  end
end
