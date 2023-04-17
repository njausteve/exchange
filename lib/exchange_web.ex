defmodule ExchangeWeb do
  @moduledoc """
  The main ExchangeWeb module.
  """
  def child_spec(_arg) do
    Plug.Cowboy.child_spec(
      scheme: :http,
      options: [port: 4050],
      plug: ExchangeWeb.Router
    )
  end
end
