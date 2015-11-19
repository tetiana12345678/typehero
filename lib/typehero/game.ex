defmodule Typehero.Game do
  use GenServer

  @registered_name TypeheroGame

  def start_link do
    GenServer.start_link(__MODULE__, %{}, [name: @registered_name])
  end

end
