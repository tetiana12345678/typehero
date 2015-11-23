defmodule Typehero.RoomChannel do
  use Phoenix.Channel
  alias Typehero.Repo
  alias Typehero.Text

  def join("rooms:lobby", message, socket) do
    {:ok, serial} = Serial.start_link

    Serial.open(serial, "/dev/cu.usbmodem1411")
    Serial.set_speed(serial, 9600)
    Serial.connect(serial)
    # socket = assign(socket, :key_index, 0)
    {:ok, socket}
  end

  def handle_info({:elixir_serial, serial, data}, state) do
    #do something with data.
    IO.inspect data
    broadcast state, "hello:world", %{data: data}

    {:noreply, state}
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
