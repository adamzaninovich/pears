defmodule Pears.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :binary_data, :binary
      add :binary_type, :string

      timestamps()
    end

  end
end
