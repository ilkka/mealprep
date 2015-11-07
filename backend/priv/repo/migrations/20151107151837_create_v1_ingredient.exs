defmodule MealprepBackend.Repo.Migrations.CreateV1.Ingredient do
  use Ecto.Migration

  def change do
    create table(:ingredients) do
      add :name, :string

      timestamps
    end

  end
end