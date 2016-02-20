defmodule Typehero.Word do
  use GenServer

  def check(process, letter) do
    GenServer.call(process, {:check, letter})
  end

  def position(process) do
    GenServer.call(process, :position)
  end

  def start_link(word) do
    GenServer.start_link(__MODULE__, word)
  end

  def init(word) do
    {:ok, _} = :timer.send_interval(2000, :move_y)
    { :ok, %{word: word, x: 0, y: 0}}
  end

  def handle_call({:check, letter}, _from, %{word: word} = state) do
    case word do
      <<^letter>> -> {:stop, :normal, :finish, state }
      <<^letter, rest::binary>> -> {:reply, :ok, %{state | word: rest}}
      _ -> {:reply, :error, state}
    end
  end

  def handle_call(:position, _from, %{x: x, y: y } = state) do
    {:reply, {x, y}, state}
  end

  def handle_info(:move_y, %{y: y} = state) do
    {:noreply, %{state | y: y + 10}}
  end
end
