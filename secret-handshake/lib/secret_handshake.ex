defmodule SecretHandshake do
  use Bitwise

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    [8, 4, 2, 1, 16] # 16 has to be at the very end otherwise it reverses empty list
    |> Enum.reduce([], fn (command, actions) -> add_command(command &&& code, actions) end)
  end

  def add_command(1, actions), do: [ "wink" | actions ]
  def add_command(2, actions), do: [ "double blink" | actions ]
  def add_command(4, actions), do: [ "close your eyes" | actions ]
  def add_command(8, actions), do: [ "jump" | actions ]
  def add_command(16, actions), do: Enum.reverse(actions)
  def add_command(_, actions), do: actions
end
