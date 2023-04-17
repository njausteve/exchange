defmodule ExchangeWeb do
  def child_spec(_arg) do
    Plug.Cowboy.child_spec(
      scheme: :http,
      options: [port: 4003],
      plug: ExchangeWeb.Router
    )
  end
end
