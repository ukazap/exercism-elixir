defmodule RobotSimulator do
  alias RobotSimulator, as: Robot
  defstruct [position: {0, 0}, direction: :north]

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(), do: %Robot{}
  def create(d, _) when d not in [:north, :east, :south, :west], do: {:error, "invalid direction"}
  def create(d, {x, y} = p) when is_integer(x) and is_integer(y), do: %Robot{direction: d, position: p}
  def create(_, _), do: {:error, "invalid position"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    instructions
    |> String.split("", trim: true)
    |> Enum.reduce_while(robot, &run_valid_instruction/2)
  end

  defp run_valid_instruction(code, robot) do
    case run_instruction(code, robot) do
      nil -> {:halt, {:error, "invalid instruction"}}
      robot -> {:cont, robot}
    end
  end

  defp run_instruction("A", %{direction: :north, position: {x, y}} = robot), do: %{robot | position: {x, y + 1}}
  defp run_instruction("A", %{direction: :east, position: {x, y}} = robot),  do: %{robot | position: {x + 1, y}}
  defp run_instruction("A", %{direction: :south, position: {x, y}} = robot), do: %{robot | position: {x, y - 1}}
  defp run_instruction("A", %{direction: :west, position: {x, y}} = robot),  do: %{robot | position: {x - 1, y}}

  defp run_instruction("L", %{direction: :north} = robot), do: %{robot | direction: :west}
  defp run_instruction("L", %{direction: :east} = robot),  do: %{robot | direction: :north}
  defp run_instruction("L", %{direction: :south} = robot), do: %{robot | direction: :east}
  defp run_instruction("L", %{direction: :west} = robot),  do: %{robot | direction: :south}

  defp run_instruction("R", %{direction: :north} = robot), do: %{robot | direction: :east}
  defp run_instruction("R", %{direction: :east} = robot),  do: %{robot | direction: :south}
  defp run_instruction("R", %{direction: :south} = robot), do: %{robot | direction: :west}
  defp run_instruction("R", %{direction: :west} = robot),  do: %{robot | direction: :north}

  defp run_instruction(_, _), do: nil

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot), do: robot.direction

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot), do: robot.position
end
