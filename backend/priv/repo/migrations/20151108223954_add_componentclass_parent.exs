defmodule MealprepBackend.Repo.Migrations.AddComponentclassParent do
  use Ecto.Migration

  def change do
    alter table(:componentclasses) do
      add :parent_id, references(:componentclasses)
    end
  end
end
