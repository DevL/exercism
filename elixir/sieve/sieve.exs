defmodule Sieve do
  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
    2..limit
    |> Enum.to_list
    |> collect_primes([])
    |> Enum.reverse
  end

  defp collect_primes([], primes), do: primes
  defp collect_primes([prime|candidates], primes) do
    collect_primes(remove_candidates(prime, candidates), [prime|primes])
  end

  defp remove_candidates(prime, candidates) do
    candidates
    |> Enum.reject &divisible_by(&1, prime)
  end

  defp divisible_by(candidate, prime), do: rem(candidate, prime) == 0
 end
