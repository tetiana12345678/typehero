defmodule Typehero.GameServer do
  use GenServer
  alias Typehero.Repo
  alias Typehero.Text
  require Logger

  defstruct [
    text: "No content",
    text_id: 3
  ]

  def start_link(state, opts) do
    Logger.debug "game server start link state:, opts: #{inspect state} #{inspect opts}"
    text = Repo.get(Text, opts[:text_id])
    Logger.debug "text.content #{inspect text}"
    state = %{text: "No content"}
    unless is_nil text do
      state = %{state | text: text}
    end
    Logger.debug "game server start link/2 #{inspect state} #{inspect opts}"
    GenServer.start_link(__MODULE__, state, opts)
  end

  def get_text(pid) do
    GenServer.call(pid, :get_text)
  end

  def handle_call(:get_text, _from, state) do
    {:reply, state.text, state}
  end
end


