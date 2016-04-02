defmodule MealprepBackend.Repo.Migrations.CreateV1.MealIngredient do
  use Ecto.Migration

  def change do
    create table(:mealingredients) do
      add :amount, :float

      add :meal_id, references(:meals)
      add :ingredient_id, references(:ingredients)

      timestamps
    end

  end
end
