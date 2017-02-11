defmodule MealprepBackend.V1.Meal do
  use MealprepBackend.Web, :model

  schema "meals" do
    field :name, :string

    has_many :ingredients, MealprepBackend.V1.MealIngredient

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
