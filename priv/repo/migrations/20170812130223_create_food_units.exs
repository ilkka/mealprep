defmodule Mealprep.Repo.Migrations.CreateFood_Units do
  use Ecto.Migration

  def change do
    create table(:food_units) do
      add :thscode, :string

      timestamps()
    end

  end
end
