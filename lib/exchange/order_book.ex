defmodule Exchange.OrderBook do
  @moduledoc """
  This module represents the order book.
  """
  @behaviour Exchange.OrderBook.Behavior

  alias Exchange.Event
  alias Exchange.OrderBook.Entry
  alias Exchange.State

  @orderlist_mapping %{bid: :bids, ask: :asks}

  @impl true
  def add_event(%State{} = state, %Event{side: :bid, price: price} = event) do
    {:ok, %State{state | bids: Map.put(state.bids, price, event)}}
  end

  def add_event(%State{} = state, %Event{side: :ask, price: price} = event) do
    {:ok, %State{state | asks: Map.put(state.asks, price, event)}}
  end

  @impl true
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

  @impl true
  def delete_event(%State{} = state, %Event{side: side, price: price}) do
    order_side = @orderlist_mapping[side]
    order_side_map = Map.get(state, order_side)

    updated_order = Map.delete(order_side_map, price)

    {:ok, Map.put(state, order_side, updated_order)}
  end

  @impl true
  def get_orders(%{bids: bids, asks: asks}, book_depth) do
    bids =
      bids
      |> Map.keys()
      |> Enum.sort(&(&1 >= &2))
      |> Enum.take(book_depth)
      |> Enum.map(fn p -> Map.get(bids, p) end)

    asks =
      asks
      |> Map.keys()
      |> Enum.sort(&(&1 <= &2))
      |> Enum.take(book_depth)
      |> Enum.map(fn p -> Map.get(asks, p) end)

    merge(asks, bids, book_depth)
  end

  defp get_bid_or_ask(order_book, side) do
    Map.get(order_book, @orderlist_mapping[side])
  end

  defp merge(asks, bids, book_depth) do
    {padded_asks, padded_bids} = pad_lists(asks, bids, book_depth)

    Enum.zip_with(padded_asks, padded_bids, fn ask, bid ->
      Map.from_struct(%Entry{
        ask_price: ask.price || 0.0,
        ask_quantity: ask.quantity || 0.0,
        bid_price: bid.price || 0.0,
        bid_quantity: bid.quantity || 0.0
      })
    end)
  end

  defp pad_lists(asks, bids, book_depth) do
    ask_length = length(asks)
    bid_length = length(bids)

    max_length =
      ask_length
      |> max(bid_length)
      |> max(book_depth)

    padded_asks = asks ++ List.duplicate(%Event{}, max_length - ask_length)
    padded_bids = bids ++ List.duplicate(%Event{}, max_length - bid_length)

    {padded_asks, padded_bids}
  end
end
