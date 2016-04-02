defmodule MealprepBackend.Repo.Migrations.CreateV1.Meal do
  use Ecto.Migration

  def change do
    create table(:meals) do
      add :name, :string

      timestamps
    end

  end
end
