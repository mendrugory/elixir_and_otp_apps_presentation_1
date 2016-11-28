defmodule MyProject.RandomNumber do
  use GenServer
  require Logger

  def start_link(_state, _opts) do
    Logger.info ("RandomNumber begins ...")
    GenServer.start_link(__MODULE__, %{}, [name: __MODULE__])
  end

  def execute(numbers) do
    GenServer.call(__MODULE__, {:calculate, numbers})
  end

  defp calculate(0, acc) do
    acc
  end

  defp calculate(numbers, acc) do
    calculate(numbers - 1, [:rand.uniform() | acc])
  end

  def handle_call({:calculate, numbers}, from, state) do
    numbers = calculate(numbers, [])
    {:reply, numbers, state}
  end

end
