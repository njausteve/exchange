defmodule Exchange.OrderBook do
  @moduledoc """
  This module represents the order book.
  """
  @behaviour Exchange.OrderBook.Behavior

  alias Exchange.Event
  alias Exchange.State

  @orderlist_mapping %{bid: :bids, ask: :asks}

  @impl true
  def add_event(%State{} = state, %Event{side: :bid, price: price} = event) do
    {:ok, %State{state | bids: Map.put(state.bids, price, event)}}
  end

  def add_event(%State{} = state, %Event{side: :ask, price: price} = event) do
    {:ok, %State{state | asks: Map.put(state.asks, price, event)}}
  end

  def update_event(%State{} = state, %Event{side: side, price: price} = event) do
    order_side = @orderlist_mapping[side]
    order_side_map = Map.get(state, order_side)

    if Map.has_key?(order_side_map, price) do
      updated_order = Map.put(order_side_map, price, event)

      {:ok, Map.put(state, order_side, updated_order)}
    else
      {:error, :none_existing_order}
    end
  end
end
