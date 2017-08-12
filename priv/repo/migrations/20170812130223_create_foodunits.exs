defmodule Mealprep.Repo.Migrations.CreateFoodunits do
  use Ecto.Migration

  def change do
    create table(:foodunits) do
      add :thscode, :string

      timestamps()
    end

  end
end
