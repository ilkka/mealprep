defmodule Mealprep.Language do
  use Ecto.Schema
  import Ecto.Changeset
  alias Mealprep.Language


  schema "languages" do
    field :englishName, :string
    field :ietfTag, :string
    field :isoCode, :string
    field :nativeName, :string

    timestamps()
  end

  @doc false
  def changeset(%Language{} = language, attrs) do
    language
    |> cast(attrs, [:isoCode, :ietfTag, :nativeName, :englishName])
    |> validate_required([:isoCode, :ietfTag, :nativeName, :englishName])
  end
end
