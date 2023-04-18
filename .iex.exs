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

event_7 = %{
  instruction: :new,
  side: :bid,
  price_level_index: 1,
  price: 230.0,
  quantity: 19
}

## Seed events to the runnung gen server
events = [event_1, event_2, event_3, event_4, event_5, event_6, event_7]

# ideal commands described in the instructions
# {:ok, xchange_pid} = Exchange.start_link()

# Exchange.send_instruction(exchange_pid, event_1)
# Exchange.order_book(exchange_pid, 4)

# since we are starting the exhange server as part of the apps supervision tree,
# we dont need to start it manually as it gets started automatically.

# Note the exchange_pid is now a registered name: `Exchange`

# Add all events.
## Enum.each(events, fn event -> Exchange.send_instruction(Exchange, event) end)
