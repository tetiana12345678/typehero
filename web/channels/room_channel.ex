defmodule Typehero.RoomChannel do
  use Phoenix.Channel

  def join("rooms:lobby", msg, socket) do
    {:ok, serial} = Serial.start_link

    Serial.open(serial, "/dev/cu.usbmodem1411")
    Serial.set_speed(serial, 9600)
    Serial.connect(serial)
    # socket = assign(socket, :key_index, 0)
    {:ok, socket}
  end

  def handle_info({:elixir_serial, serial, data}, state) do
    #do something with data.
    cond do
      data =~ ~r/1/ -> broadcast state, "arduino:finger", %{finger: 1}
      data =~ ~r/2/ -> broadcast state, "arduino:finger", %{finger: 2}
      data =~ ~r/3/ -> broadcast state, "arduino:finger", %{finger: 3}
      true -> nil
    end

    {:noreply, state}
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
