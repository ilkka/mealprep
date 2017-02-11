defmodule MealprepBackend.Repo.Migrations.CreateV1.Ingredient do
  use Ecto.Migration

  def change do
    create table(:ingredients) do
      add :name, :string
      add :edible_portion, :integer
      add :ingredientclass_id, references(:ingredientclasses)

      timestamps()
    end

  end
end
