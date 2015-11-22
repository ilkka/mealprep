defmodule MealprepBackend.Repo.Migrations.AddComponentVisibility do
  use Ecto.Migration

  def change do
    alter table(:components) do
      add :visible, :bool, default: false
    end

  end
end
