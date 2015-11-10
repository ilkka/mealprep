defmodule MealprepBackend.V1.ComponentValue do
  use MealprepBackend.Web, :model

  schema "componentvalues" do
    field :value, :float

    belongs_to :component, MealprepBackend.V1.Component
    belongs_to :ingredient, MealprepBackend.V1.Ingredient

    timestamps
  end

  @required_fields ~w(value)
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
