defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t()}
  def generate(_coins, 0), do: {:ok, []}
  def generate([smallest_coin | _], target) when target < smallest_coin, do: {:error, "cannot change"}
  def generate(coins, target) do
    1..target
    |> Enum.reduce(%{0 => []}, fn (current_target, changes_memo) ->
         generate_change(current_target, changes_memo, coins)
       end)
    |> Map.get(target)
    |> format
  end

  defp generate_change(target, changes_memo, possible_coins) do
    possible_coins
    |> Enum.filter(fn coin -> changes_memo[target - coin] end) # filter out coins that are too small
    |> Enum.map(fn coin -> [coin | changes_memo[target - coin]] end) # add the coins to the changes
    |> Enum.min_by(&(length(&1)), fn -> nil end) # find the change with smallest length
    |> (&Map.put(changes_memo, target, &1)).() # update the changes_memo for later calculations
  end

  defp format(nil), do: {:error, "cannot change"}
  defp format(change), do: {:ok, change}
end