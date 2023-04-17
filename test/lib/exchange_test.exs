defmodule ExchangeTest do
  @moduledoc false

  use ExUnit.Case, async: true

  describe "start_link/0" do
    test "starts the exchange successfully" do
      assert is_pid(start_link_supervised!(Exchange))
    end
  end

  describe "send_instruction/2" do
    setup do
      exchange = start_link_supervised!(Exchange)

      %{exchange: exchange}
    end

    test "sends an instruction to the exchange", %{exchange: exchange} do
      event = %{
        instruction: :new,
        side: :bid,
        price: 50.0,
        price_level_index: 1,
        quantity: 30
      }

      assert :ok = Exchange.send_instruction(exchange, event)
    end
  end
end
