defmodule Typehero.Text do
  use Typehero.Web, :model

  schema "texts" do
    field :content, :string

    timestamps
  end

  @required_fields ~w(content)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def last(query) do
    from p in query,
    order_by: [desc: p.id],
    limit: 1
  end

end
