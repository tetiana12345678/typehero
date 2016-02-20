defmodule Typehero do
  use Application
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(Typehero.Endpoint, []),
      worker(Typehero.Repo, []),
      supervisor(Typehero.Game, [])
    ]
    opts = [strategy: :one_for_one, name: Typehero.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
