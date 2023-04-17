defmodule Exchange.Event do
  @moduledoc """
  This module defines the `Event` struct, which represents an event that occurs in a financial exchange.

  An event can represent a new order, an update to an existing order, or a deletion of an existing order.
  """

  @typedoc """
  A struct that represents an event that occurs in a financial exchange.

  * `:instruction` - The type of the event, which can be `:new`, `:update`, or `:delete`.
  * `:side` - The side of the order, which can be `:bid` or `:ask`.
  * `:price_level_index` - The index of the price level at which the order is placed.
  * `:price` - The price of the order.
  * `:quantity` - The quantity of the order.

  All prices are represented as floats, and quantities are represented as positive integers.
  """

  @type t :: %__MODULE__{
          instruction: :new | :update | :delete,
          side: :bid | :ask,
          price_level_index: pos_integer(),
          price: float(),
          quantity: pos_integer()
        }

  @allowed_instructions [:new, :update, :delete]
  @allowed_sides [:bid, :ask]

  alias __MODULE__

  defstruct [:instruction, :side, :price_level_index, :price, :quantity]

  @spec new(map) :: {:ok, Event.t()} | {:error, term()}
  def new(event) do
    with {:ok, instruction} <- parse_instruction(event),
         {:ok, side} <- parse_side(event),
         {:ok, price_level_index} <- parse_price_level_index(event),
         {:ok, price} <- parse_price(event),
         {:ok, quantity} <- parse_quantity(event) do
      {:ok,
       %__MODULE__{
         instruction: instruction,
         side: side,
         price_level_index: price_level_index,
         price: price,
         quantity: quantity
       }}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  defp parse_instruction(%{instruction: instruction}) when instruction in @allowed_instructions,
    do: {:ok, instruction}

  defp parse_instruction(_), do: {:error, :unexpected_or_missing_instruction}

  defp parse_side(%{side: side}) when side in @allowed_sides, do: {:ok, side}
  defp parse_side(_), do: {:error, :unexpected_or_missing_side}

  defp parse_price_level_index(%{price_level_index: price_level_index})
       when is_integer(price_level_index) and price_level_index > 0,
       do: {:ok, price_level_index}

  defp parse_price_level_index(_), do: {:error, :unexpected_or_missing_price_level_index}

  defp parse_price(%{price: price}) when is_float(price), do: {:ok, price}
  defp parse_price(_), do: {:error, :unexpected_or_missing_price}

  defp parse_quantity(%{quantity: quantity}) when is_integer(quantity) and quantity > 0,
    do: {:ok, quantity}

  defp parse_quantity(_), do: {:error, :unexpected_or_missing_quantity}
end
