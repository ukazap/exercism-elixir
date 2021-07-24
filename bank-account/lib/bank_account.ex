defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """
  defstruct [balance: 0, open?: true] 

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, pid} = Agent.start_link(fn -> %BankAccount{} end)
    pid
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    Agent.update(account, &(%{&1 | open?: false}))
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    Agent.get(account, fn a ->
      case a.open? do
        true -> a.balance
        false -> {:error, :account_closed}
      end
    end)
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    case balance(account) do
      {:error, _} = error -> error
      _ -> Agent.update(account, &(%{&1 | balance: &1.balance + amount}))
    end
  end
end
