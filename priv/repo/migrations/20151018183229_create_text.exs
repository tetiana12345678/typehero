defmodule Typehero.Repo.Migrations.CreateText do
  use Ecto.Migration

  def change do
    create table(:texts) do
      add :content, :string

      timestamps
    end

  end
end
