defmodule Typehero.PageController do
  use Typehero.Web, :controller
  alias Typehero.Text
  alias Typehero.Repo
  alias Typehero.GameServer
  alias Typehero.GameSupervisor

  def index(conn, _params) do
    texts = Repo.all(Text)
    render(conn, "index.html", texts: texts)
  end
end
