defmodule Pears.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :provider, :string
      add :admin, :boolean, default: false
      add :token, :string

      timestamps()
    end
  end
end
