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

    test "sends an event to the exchange and recieves an :ok", %{exchange: exchange} do
      event = %{
        instruction: :new,
        side: :bid,
        price: 50.0,
        price_level_index: 1,
        quantity: 30
      }

      assert :ok = Exchange.send_instruction(exchange, event)
    end

    test ":new returns and error if the event is not in the expected format", %{
      exchange: exchange
    } do
      event = %{
        instruction: :cancel,
        side: :bid,
        price: 50.0,
        price_level_index: 1,
        quantity: 30
      }

      assert {:error, :unexpected_or_missing_instruction} =
               Exchange.send_instruction(exchange, event)
    end

    test ":update instruction returns error for a non existent price", %{exchange: exchange} do
      event = %{
        instruction: :update,
        side: :bid,
        price: 50.0,
        price_level_index: 1,
        quantity: 30
      }

      assert {:error, :none_existing_order} = Exchange.send_instruction(exchange, event)
    end

    test ":update instruction updates order and returns :ok", %{exchange: exchange} do
      event = %{
        instruction: :update,
        side: :bid,
        price: 50.0,
        price_level_index: 1,
        quantity: 30
      }

      Exchange.send_instruction(exchange, event)

      update_event = %{
        instruction: :new,
        side: :bid,
        price: 50.0,
        price_level_index: 1,
        quantity: 50
      }

      assert :ok = Exchange.send_instruction(exchange, update_event)
    end
  end
end
