defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l), do: reduce(l, 0, fn (i, accumulator) -> accumulator + 1 end)

  @spec reverse(list) :: list
  def reverse(list), do: reduce(list, [], fn (i, accumulator) -> [i | accumulator] end)

  @spec map(list, (any -> any)) :: list
  def map([] = empty_list, _mapper), do: empty_list
  def map([head | tail], mapper), do: [mapper.(head) | map(tail, mapper)]

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([] = empty_list, _filterer), do: empty_list
  def filter([head | tail], filterer) do
    if filterer.(head), do: [head | filter(tail, filterer)], else: filter(tail, filterer)
  end

  @type accumulator :: any
  @spec reduce(list, accumulator, (any, accumulator -> accumulator)) :: accumulator
  def reduce([], accumulator, _), do: accumulator
  def reduce([head | tail], accumulator, reducer), do: reduce(tail, reducer.(head, accumulator), reducer)

  @spec append(list, list) :: list
  def append([], b), do: b
  def append(a, []), do: a
  def append([head | tail], b), do: [head | append(tail, b)]

  @spec concat([[any]]) :: [any]
  def concat([] = empty_list), do: empty_list
  def concat([head | tail]), do: append(head, concat(tail))
end
