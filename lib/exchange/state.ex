defmodule Exchange.State do
  @moduledoc """
  This module represents the state of the exchange.
  """
  @type t :: %__MODULE__{
          asks: %{},
          bids: %{}
        }

  defstruct [:asks, :bids]
end
