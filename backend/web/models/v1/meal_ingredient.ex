defmodule MealprepBackend.V1.MealIngredient do
  use MealprepBackend.Web, :model

  schema "mealingredients" do
    field :amount, :float

    belongs_to :meal, MealprepBackend.V1.Meal
    belongs_to :ingredient, MealprepBackend.V1.Ingredient
    
    timestamps
  end

  @required_fields ~w(amount)
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
