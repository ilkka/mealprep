defmodule MealprepBackend.Repo.Migrations.CreateV1.ComponentValue do
  use Ecto.Migration

  def change do
    create table(:componentvalues) do
      add :value, :float

      add :component_id, references(:components)
      add :ingredient_id, references(:ingredients)

      timestamps
    end

  end
end
