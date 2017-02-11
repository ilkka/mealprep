defmodule MealprepBackend.Repo.Migrations.CreateV1.ComponentClass do
  use Ecto.Migration

  def change do
    create table(:componentclasses) do
      add :name, :string
      add :thscode, :string

      timestamps()
    end

  end
end
