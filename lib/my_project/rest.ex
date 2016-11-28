defmodule MyProject.Rest do
  use Plug.Router
  alias MyProject.RandomNumber
  require Logger

  plug :match
  plug :dispatch

  def start_link(_state, _opts) do
    Logger.info ("API Rest is working ...")
    Plug.Adapters.Cowboy.http(__MODULE__, [], port: 4000)
  end

  get "/" do
    conn
    |> send_resp(200, "Welcome to the REST API of the Workshop !!")
  end

  get "/numbers/:numbers" do
    random_numbers = numbers 
    |> String.to_integer() 
    |> RandomNumber.execute()
    result = %{numbers: random_numbers, timestamp: :os.system_time(:seconds)} 
    |> Poison.encode!(strict_keys: true)
    conn
    |> send_resp(200, result)
  end
end
