defmodule ExchangeWeb.Router do
  use Plug.Router

  alias Exchange

  @default_depth 10

  plug(:match)

  # Attach the Logger to log incoming requests
  plug(Plug.Logger)
  plug(Plug.Parsers, parsers: [:json], pass: ["application/json"], json_decoder: Jason)

  plug(:dispatch)

  get "/orders" do
    with orders <- Exchange.order_book(Exchange, @default_depth),
         {:ok, orders} <- Jason.encode(orders) do
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, orders)
    else
      {:error, reason} ->
        send_resp(conn, 500, reason)
    end
  end

  match _ do
    send_resp(conn, 200, "Hi welcome to the exchange!\n")
  end
end
