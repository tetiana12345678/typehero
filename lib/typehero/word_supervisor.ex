defmodule Typehero.WordSupervisor do
  def start_link do
    import Supervisor.Spec, warn: false
    children = [
      worker(Typehero.Word, [], [restart: :transient])
    ]
    opts = [strategy: :simple_one_for_one, max_restart: 0, name: __MODULE__]
    Supervisor.start_link(children, opts)
  end

  def start_word(word) do
    Supervisor.start_child(__MODULE__, [word])
  end
end
