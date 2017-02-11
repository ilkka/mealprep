defmodule MealprepBackend.V1.IngredientClass do
  use MealprepBackend.Web, :model

  schema "ingredientclasses" do
    field :name, :string
    field :thscode, :string

    has_many :ingredients, MealprepBackend.V1.Ingredient
    belongs_to :parent, MealprepBackend.V1.IngredientClass

    timestamps()
  end

  @required_fields ~w(name)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
