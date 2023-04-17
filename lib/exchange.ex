defmodule Exchange do
  @moduledoc """
  Documentation for `Exchange`.
  """

  alias Exchange.Event
  alias Exchange.OrderBook
  alias Exchange.State

  use GenServer

  @type exchange_pid :: pid()

  def start_link(_) do
    state = %State{}

    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @spec send_instruction(exchange_pid, map()) :: :ok | {:error, any()}
  def send_instruction(pid, instruction) do
    GenServer.call(pid, {:instruction, instruction})
  end

  @impl true
  def handle_call({:instruction, event}, _from, state) do
    with {:ok, event} <- Event.new(event),
         {:ok, state} <- process_event(state, event) do
      {:reply, :ok, state}
    else
      {:error, reason} -> {:reply, {:error, reason}, state}
    end
  end

  defp process_event(state, %Event{instruction: instruction} = event) do
    case instruction do
      :new -> OrderBook.add_event(state, event)
      :update -> OrderBook.update_event(state, event)
      :delete -> OrderBook.delete_event(state, event)
    end
  end
end
