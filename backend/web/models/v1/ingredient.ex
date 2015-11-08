defmodule MealprepBackend.V1.Ingredient do
  use MealprepBackend.Web, :model

  schema "ingredients" do
    field :name, :string
    field :edible_portion, :integer, default: 100

    belongs_to :process, MealprepBackend.V1.Process
    belongs_to :ingredientclass, MealprepBackend.V1.IngredientClass

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
