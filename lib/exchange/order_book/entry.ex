defmodule Exchange.OrderBook.Entry do
  @moduledoc """
  This module defines the `OrderBookEntry` struct, which represents a single entry
  in an order book for a financial exchange.

  An order book entry contains the best bid and ask prices, as well as the corresponding
  quantities available at those prices.
  """

  @typedoc """
  A struct that represents a single entry in an order book for a financial exchange.

  * `:bid_price` - The highest price at which buyers are willing to buy this asset.
  * `:bid_quantity` - The quantity of the asset available at the best bid price.
  * `:ask_price` - The lowest price at which sellers are willing to sell this asset.
  * `:ask_quantity` - The quantity of the asset available at the best ask price.

  All prices are represented as floats, and quantities are represented as non-negative integers.
  """

  @type t :: %__MODULE__{
          bid_price: float(),
          bid_quantity: non_neg_integer(),
          ask_price: float(),
          ask_quantity: non_neg_integer()
        }

  defstruct [:bid_price, :bid_quantity, :ask_price, :ask_quantity]
end
