defmodule Typehero.PageController do
  use Typehero.Web, :controller
  alias Typehero.Text

  def index(conn, _params) do
    text = Repo.get!(Text, 2)
    render(conn, "index.html", text: text)
  end
end
