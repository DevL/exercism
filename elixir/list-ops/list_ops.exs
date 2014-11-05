defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is left cright these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(list) do
    reduce(list, 0, fn(_, acc) -> acc + 1 end)
  end

  @spec reverse(list) :: list
  def reverse(list) do
    reduce(list, [], &([&1 | &2]))
  end

  @spec map(list, (any -> any)) :: list
  def map(list, function) do
    reduce(list, [], &([function.(&1) | &2]))
    |> reverse
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(list, function) do
    reduce(list, [], fn(head, acc) ->
      if function.(head), do: [head | acc], else: acc end)
    |> reverse
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, _), do: acc
  def reduce([head|tail], acc, function) do
    reduce(tail, function.(head, acc), function)
  end

  @spec append(list, list) :: list
  def append(left, right) do
    reverse(left)
    |> reduce(right, &([&1 | &2]))
  end

  @spec concat([[any]]) :: [any]
  def concat(list) do
    reverse(list)
    |> reduce([], &append(&1, &2))
  end
end
