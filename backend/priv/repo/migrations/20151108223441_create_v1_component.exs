defmodule MealprepBackend.Repo.Migrations.CreateV1.Component do
  use Ecto.Migration

  def change do
    create table(:components) do
      add :name, :string

      add :unit_id, references(:units)
      add :componentclass_id, references(:componentclasses)

      timestamps
    end

  end
end
