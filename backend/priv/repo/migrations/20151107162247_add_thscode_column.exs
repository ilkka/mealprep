defmodule MealprepBackend.Repo.Migrations.AddThscodeColumn do
  use Ecto.Migration

  def change do
    alter table(:ingredientclasses) do
      add :thscode, :string
    end
  end
end
