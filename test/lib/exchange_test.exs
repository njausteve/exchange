defmodule ExchangeTest do
  @moduledoc false

  use ExUnit.Case

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

    test ":delete instruction updates order and returns :ok", %{exchange: exchange} do
      event = %{
        instruction: :new,
        side: :bid,
        price: 50.0,
        price_level_index: 1,
        quantity: 30
      }

      assert :ok = Exchange.send_instruction(exchange, event)

      delete_event = %{
        instruction: :delete,
        side: :bid,
        price: 50.0,
        price_level_index: 1,
        quantity: 30
      }

      assert :ok = Exchange.send_instruction(exchange, delete_event)
    end
  end

  describe "order_book/2" do
    setup do
      exchange = start_link_supervised!(Exchange, name: __MODULE__)

      %{exchange: exchange}
    end

    test "return error if non integer is passed as depth", %{exchange: exchange} do
      assert {:error, :invalid_depth_value} = Exchange.order_book(exchange, "1")
    end

    test "returns the order book given the depth", %{exchange: exchange} do
      event_1 = %{
        instruction: :new,
        side: :bid,
        price_level_index: 1,
        price: 50.0,
        quantity: 30
      }

      event_2 = %{
        instruction: :new,
        side: :bid,
        price_level_index: 2,
        price: 40.0,
        quantity: 40
      }

      event_3 = %{
        instruction: :new,
        side: :ask,
        price_level_index: 1,
        price: 60.0,
        quantity: 10
      }

      event_4 = %{
        instruction: :new,
        side: :ask,
        price_level_index: 2,
        price: 70.0,
        quantity: 10
      }

      event_5 = %{
        instruction: :update,
        side: :ask,
        price_level_index: 2,
        price: 70.0,
        quantity: 20
      }

      event_6 = %{
        instruction: :update,
        side: :bid,
        price_level_index: 1,
        price: 50.0,
        quantity: 40
      }

      for event <- [event_1, event_2, event_3, event_4, event_5, event_6] do
        assert :ok = Exchange.send_instruction(exchange, event)
      end

      expected_order_book = [
        %{ask_price: 60.0, ask_quantity: 10, bid_price: 50.0, bid_quantity: 40},
        %{ask_price: 70.0, ask_quantity: 20, bid_price: 40.0, bid_quantity: 40}
      ]

      assert ^expected_order_book = Exchange.order_book(exchange, 2)

      event_7 = %{
        instruction: :new,
        side: :bid,
        price_level_index: 1,
        price: 230.0,
        quantity: 19
      }

      assert :ok = Exchange.send_instruction(exchange, event_7)

      expected_updated_order_book = [
        %{ask_price: 60.0, ask_quantity: 10, bid_price: 230.0, bid_quantity: 19},
        %{ask_price: 70.0, ask_quantity: 20, bid_price: 50.0, bid_quantity: 40},
        %{ask_price: 0.0, ask_quantity: 0, bid_price: 40.0, bid_quantity: 40},
        %{ask_price: 0.0, ask_quantity: 0, bid_price: 0.0, bid_quantity: 0}
      ]

      assert ^expected_updated_order_book = Exchange.order_book(exchange, 4)
    end
  end
end
