defmodule Typehero.RoomChannel do
  use Phoenix.Channel

  def join("rooms:lobby", msg, socket) do
    # socket = assign(socket, :key_index, 0)
    {:ok, socket}
  end

  def handle_in("user:join", msg, socket) do
    IO.puts " msg in user:join #{inspect msg}"
    broadcast! socket, "user:join", %{ user: msg["user"], number: msg["number"] }
    {:noreply, socket}
  end

  def handle_in("user:key", msg, socket) do
    IO.puts "msg in user:key #{ inspect msg}"
    key_index = socket.assigns[:key_index] || 0
    text = "hello world"    #text = Repo.get!(Text, 1).content
    inspect msg
    next_key = String.slice(text, key_index..key_index)
    case next_key == msg["body"] do
      true ->
        broadcast_from! socket, "user:key", %{
          user: msg["user"],
          body: msg["body"],
          number: msg["number"]
        }

        socket = assign(socket, :key_index, key_index + 1)

        {:reply, :ok, socket}
      false ->
        {:reply, :error, socket}
    end
  end
end
