defmodule MealprepBackend.Repo.Migrations.AddProcessIdToIngredient do
  use Ecto.Migration

  def change do
    alter table(:ingredients) do
      add :process_id, references(:processes)
    end
  end
end
