defmodule Mealprep.Repo.Migrations.CreateFoodUnitTrs do
  use Ecto.Migration

  def change do
    create table(:food_unit_trs) do
      add :description, :string
      add :language_id, references(:languages, on_delete: :nothing)
      add :food_unit_id, references(:food_units, on_delete: :nothing)
      
      timestamps()
    end

    create index(:food_unit_trs, [:language_id, :food_unit_id])
  end
end
