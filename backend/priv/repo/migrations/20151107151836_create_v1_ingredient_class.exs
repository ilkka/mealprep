defmodule MealprepBackend.Repo.Migrations.CreateV1.IngredientClass do
  use Ecto.Migration

  def change do
    create table(:ingredientclasses) do
      add :name, :string
      add :thscode, :string

      add :parent_id, references(:ingredientclasses)

      timestamps()
    end

  end
end
