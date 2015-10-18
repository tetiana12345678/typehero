defmodule Typehero.TextController do
  use Typehero.Web, :controller

  alias Typehero.Text

  plug :scrub_params, "text" when action in [:create, :update]

  def index(conn, _params) do
    texts = Repo.all(Text)
    render(conn, "index.html", texts: texts)
  end

  def new(conn, _params) do
    changeset = Text.changeset(%Text{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"text" => text_params}) do
    changeset = Text.changeset(%Text{}, text_params)

    case Repo.insert(changeset) do
      {:ok, _text} ->
        conn
        |> put_flash(:info, "Text created successfully.")
        |> redirect(to: text_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    text = Repo.get!(Text, id)
    render(conn, "show.html", text: text)
  end

  def edit(conn, %{"id" => id}) do
    text = Repo.get!(Text, id)
    changeset = Text.changeset(text)
    render(conn, "edit.html", text: text, changeset: changeset)
  end

  def update(conn, %{"id" => id, "text" => text_params}) do
    text = Repo.get!(Text, id)
    changeset = Text.changeset(text, text_params)

    case Repo.update(changeset) do
      {:ok, text} ->
        conn
        |> put_flash(:info, "Text updated successfully.")
        |> redirect(to: text_path(conn, :show, text))
      {:error, changeset} ->
        render(conn, "edit.html", text: text, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    text = Repo.get!(Text, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(text)

    conn
    |> put_flash(:info, "Text deleted successfully.")
    |> redirect(to: text_path(conn, :index))
  end
end
