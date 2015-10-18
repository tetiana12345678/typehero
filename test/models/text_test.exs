defmodule Typehero.TextTest do
  use Typehero.ModelCase

  alias Typehero.Text

  @valid_attrs %{content: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Text.changeset(%Text{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Text.changeset(%Text{}, @invalid_attrs)
    refute changeset.valid?
  end
end
