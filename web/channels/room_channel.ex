defmodule Typehero.RoomChannel do
  use Phoenix.Channel
  alias Typehero.GameSupervisor
  alias Typehero.GameServer
  require Logger
  alias Typehero.Repo
  alias Typehero.Text


  def join("rooms:lobby", message, socket) do
    {:ok, socket}
  end

  def join("games:" <> id, message, socket) do
    Logger.debug "Hey"
    pid = GameSupervisor.start_game(id)
    text = GameServer.get_text(pid)
    socket = assign(socket, :key_index, 1)
    socket = assign(socket, :pid, pid)
    socket = assign(socket, :text, text)
    {:ok, socket}
  end

  def handle_in("new:keystroke", msg, socket) do
    pid = socket.assigns[:pid]
    text = GameServer.get_text(pid)
    key_index = socket.assigns[:key_index]
    next_key = String.slice(text, key_index..key_index)
    Logger.debug "key_index #{key_index}"

    case next_key == msg["body"] do
      true ->
        broadcast_from! socket, "new:keystroke", %{
          user: msg["user"],
          body: msg["body"],
          counter: msg["counter"]
        }

        socket = assign(socket, :key_index, key_index + 1)
        {:reply, :ok, socket}
      false ->
        {:reply, :error, socket}
    end
  end
end
