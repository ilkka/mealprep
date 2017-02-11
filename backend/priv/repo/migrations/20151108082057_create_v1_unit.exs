defmodule MealprepBackend.Repo.Migrations.CreateV1.Unit do
  use Ecto.Migration

  def change do
    create table(:units) do
      add :name, :string
      add :thscode, :string

      timestamps()
    end

  end
end
