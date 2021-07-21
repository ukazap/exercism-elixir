defmodule Bob do
  def hey(input) do
    cond do
      String.match?(input, ~r/^\s*$/)   -> "Fine. Be that way!"
      question?(input) and loud?(input) -> "Calm down, I know what I'm doing!"
      loud?(input)                      -> "Whoa, chill out!"
      question?(input)                  -> "Sure."
      true                              -> "Whatever."
    end
  end

  defp question?(input) do
    String.match?(input, ~r/\?\s*$/)
  end

  defp loud?(input) do
    String.match?(input, ~r/[[:alpha:]]+/) and String.upcase(input) == input
  end
end
