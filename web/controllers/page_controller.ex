defmodule Typehero.PageController do
  use Typehero.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
