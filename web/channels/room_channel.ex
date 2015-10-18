defmodule Typehero.RoomChannel do
  use Phoenix.Channel

  def join("rooms:lobby", message, socket) do
    socket = assign(socket, :key_index, 0)
    {:ok, socket}
  end

  def handle_in("new:keystroke", msg, socket) do
    key_index = socket.assigns[:key_index]
    text = "Hello world"
    next_key = String.slice(text, key_index..key_index)
    case next_key == msg["body"] do
      true ->
        broadcast! socket, "new:keystroke", %{user: msg["user"], body: msg["body"]}
        socket = assign(socket, :key_index, key_index + 1)
        {:reply, :ok, socket}
      false ->
        {:reply, :error, socket}
    end
  end
end
