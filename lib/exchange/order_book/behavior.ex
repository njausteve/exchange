defmodule Exchange.OrderBook.Behavior do
  @moduledoc """
  This module represents the behavior of the order book.
  """

  alias Exchange.Event
  alias Exchange.OrderBook.Entry
  alias Exchange.State

  @type book_depth :: integer()

  @doc """
  Callback to adds an event to the order book.

  ## Parameters
    - Event: And event of type `Exchange.Event.t()`
  """
  @callback add_event(State.t(), Event.t()) :: :ok | {:error, any()}
  @callback update_event(State.t(), Event.t()) :: :ok | {:error, any()}
  @callback delete_event(State.t(), Event.t()) :: :ok | {:error, any()}
  @callback get_orders(State.t(), book_depth) :: [Entry.t()]
end
