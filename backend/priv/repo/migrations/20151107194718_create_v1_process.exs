defmodule MealprepBackend.Repo.Migrations.CreateV1.Process do
  use Ecto.Migration

  def change do
    create table(:processes) do
      add :name, :string

      timestamps
    end

  end
end
