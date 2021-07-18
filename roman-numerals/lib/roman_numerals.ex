defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(num) when num >= 1000, do: "M"  <> numeral(num - 1000)
  def numeral(num) when num >= 900,  do: "CM" <> numeral(num - 900)
  def numeral(num) when num >= 500,  do: "D"  <> numeral(num - 500)
  def numeral(num) when num >= 400,  do: "CD" <> numeral(num - 400)
  def numeral(num) when num >= 100,  do: "C"  <> numeral(num - 100)
  def numeral(num) when num >= 90,   do: "XC" <> numeral(num - 90)
  def numeral(num) when num >= 50,   do: "L"  <> numeral(num - 50)
  def numeral(num) when num >= 40,   do: "XL" <> numeral(num - 40)
  def numeral(num) when num >= 10,   do: "X"  <> numeral(num - 10)
  def numeral(num) when num >= 9,    do: "IX" <> numeral(num - 9)
  def numeral(num) when num >= 5,    do: "V"  <> numeral(num - 5)
  def numeral(num) when num >= 4,    do: "IV" <> numeral(num - 4)
  def numeral(num) when num >= 1,    do: "I"  <> numeral(num - 1)
  def numeral(num),                  do: ""
end
