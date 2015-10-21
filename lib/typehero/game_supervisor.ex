defmodule Typehero.GameSupervisor do
  alias Typehero.GameServer
  require Logger
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    children = [
      worker(GameServer, [], restart: :transient)
    ]
    supervise(children, strategy: :simple_one_for_one)
  end

  def start_game(text_id) do
    case Supervisor.start_child(__MODULE__, [[], [text_id: text_id]]) do
      {:ok, pid} -> pid
      {:error, {:already_started, pid}} -> pid
    end
  end
end
