defmodule Andyfish.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :password, :string
      add :created_at, :utc_datetime

      timestamps()
    end

  end
end
