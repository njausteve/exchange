defmodule Exchange.EventTest do
  @moduledoc false

  use ExUnit.Case, async: true
  alias Exchange.Event

  describe "new/1" do
    test "returns a new Event struct for valid input" do
      event = %{
        instruction: :new,
        side: :bid,
        price_level_index: 1,
        price: 100.0,
        quantity: 10
      }

      expected_event = %Event{
        instruction: :new,
        side: :bid,
        price_level_index: 1,
        price: 100.0,
        quantity: 10
      }

      assert {:ok, ^expected_event} = Event.new(event)
    end

    test "returns an error for invalid instruction" do
      event = %{
        instruction: :cancel,
        side: :bid,
        price_level_index: 1,
        price: 100.0,
        quantity: 10
      }

      assert {:error, :unexpected_or_missing_instruction} = Event.new(event)
    end

    test "returns an error for invalid side" do
      event = %{
        instruction: :new,
        side: :invalid,
        price_level_index: 1,
        price: 100.0,
        quantity: 10
      }

      assert {:error, :unexpected_or_missing_side} = Event.new(event)
    end

    test "returns an error for invalid price level index" do
      event = %{
        instruction: :new,
        side: :bid,
        price_level_index: -1,
        price: 100.0,
        quantity: 10
      }

      assert {:error, :unexpected_or_missing_price_level_index} = Event.new(event)
    end

    test "returns an error for invalid price" do
      event = %{
        instruction: :new,
        side: :bid,
        price_level_index: 1,
        price: "invalid",
        quantity: 10
      }

      assert {:error, :unexpected_or_missing_price} = Event.new(event)
    end

    test "returns an error for invalid quantity" do
      event = %{
        instruction: :new,
        side: :bid,
        price_level_index: 1,
        price: 100.0,
        quantity: -1
      }

      assert {:error, :unexpected_or_missing_quantity} = Event.new(event)
    end
  end
end
