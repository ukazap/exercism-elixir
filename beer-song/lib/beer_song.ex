defmodule BeerSong do
  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range) do
    range
    |> Enum.to_list
    |> Enum.map(fn bottle_count -> verse(bottle_count) end)
    |> Enum.join("\n")
  end

  def lyrics(), do: lyrics(99..0)

  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(0) do
    """
    No more bottles of beer on the wall, no more bottles of beer.
    Go to the store and buy some more, 99 bottles of beer on the wall.
    """
  end

  def verse(number) do
    """
    #{pluralize_bottle(number)} of beer on the wall, #{pluralize_bottle(number)} of beer.
    #{take_what_down(number)} and pass it around, #{pluralize_bottle(number - 1)} of beer on the wall.
    """
  end

  defp pluralize_bottle(1), do: "1 bottle"
  defp pluralize_bottle(0), do: "no more bottles"
  defp pluralize_bottle(n), do: "#{n} bottles"

  defp take_what_down(1), do: "Take it down"
  defp take_what_down(n), do: "Take one down"
end
