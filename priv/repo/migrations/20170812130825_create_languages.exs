defmodule Mealprep.Repo.Migrations.CreateLanguages do
  use Ecto.Migration

  def change do
    create table(:languages) do
      add :isoCode, :string
      add :ietfTag, :string
      add :nativeName, :string
      add :englishName, :string

      timestamps()
    end

  end
end
