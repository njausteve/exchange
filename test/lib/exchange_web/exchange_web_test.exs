defmodule Exchange.RouterTest do
  use ExUnit.Case
  use Plug.Test

  alias ExchangeWeb.Router

  @opts Router.init([])

  test "GET /orders returns orders" do
    conn =
      :get
      |> conn("/orders")
      |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 200
  end

  test "GET / returns a welcome message" do
    conn =
      :get
      |> conn("/")
      |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 200

    assert conn.resp_body == "Hi welcome to the exchange!\n"
  end
end
