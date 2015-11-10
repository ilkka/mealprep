defmodule MealprepBackend.Repo.Migrations.AddFoodidToFood do
  use Ecto.Migration

  def change do
    alter table(:ingredients) do
      add :fineli_foodid, :integer
    end
  end
end
