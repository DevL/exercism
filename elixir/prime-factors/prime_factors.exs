defmodule PrimeFactors do
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
  defp factors_for(number, divisor, factors) do
    if rem(number, divisor) == 0  do
      factors_for(trunc(number / divisor), 2, [divisor|factors])
    else
      factors_for(number, divisor + 1, factors)
    end
  end
end
