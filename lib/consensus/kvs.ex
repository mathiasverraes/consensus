defmodule Consensus.Kvs do
  @moduledoc false
  
  use GenServer

  defstruct values: %{}

  def start_link(state, opts) do
    GenServer.start_link(__MODULE__, state, opts)
  end


# API

  def put(pid, key, value) do
    GenServer.cast(pid, {:put, key, value})
  end

  def get(pid, key) do
    GenServer.call(pid, {:get, key})
  end

# Callbacks

  def init(_opts) do
    {:ok, %Consensus.Kvs{}}
  end

  def handle_call({:get, key}, _from, state) do
    {
      :reply,
      Map.get(state.values, key),
      state
    }
  end

  def handle_cast({:put, key, value}, state) do
    {
      :noreply,
      %{state | values: Map.put(state.values, key, value) }
    }
  end
end