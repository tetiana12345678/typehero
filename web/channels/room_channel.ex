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
    broadcast! socket, "user:join", %{ user: msg["user"] }
    {:noreply, socket}
  end

  def handle_in("user:key", msg, socket) do
    key_index = socket.assigns[:key_index] || 0
    IO.puts("hello #{key_index} ")
    text = "hello world"
    next_key = String.slice(text, key_index..key_index)
    case next_key == msg["body"] do
      true ->
        broadcast! socket, "user:key", %{
          user: msg["user"],
          body: msg["body"]
        }

        socket = assign(socket, :key_index, key_index + 1)

        {:reply, :ok, socket}
      false ->
        {:reply, :error, socket}
    end
  end

  # def handle_in("new:keystroke", msg, socket) do
  #   key_index = socket.assigns[:key_index]
  #   text = Repo.get!(Text, 1).content
  #   next_key = String.slice(text, key_index..key_index)
  #   case next_key == msg["body"] do
  #     true ->
  #       broadcast_from! socket, "new:keystroke", %{
  #         user: msg["user"],
  #         body: msg["body"],
  #         counter: msg["counter"]
  #       }

  #       socket = assign(socket, :key_index, key_index + 1)
  #       {:reply, :ok, socket}
  #     false ->
  #       {:reply, :error, socket}
  #   end
  # end
end
