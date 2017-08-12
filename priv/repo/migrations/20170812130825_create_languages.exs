defmodule Mealprep.Repo.Migrations.CreateLanguages do
  use Ecto.Migration

  def change do
    create table(:languages) do
      add :ietfTag, :string
      add :nativeName, :string
      add :englishName, :string

      timestamps()
    end

    create index(:languages, [:ietfTag], unique: true)
  end
end
