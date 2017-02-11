defmodule MealprepBackend.V1.Process do
  use MealprepBackend.Web, :model

  schema "processes" do
    field :name, :string
    field :thscode, :string

    has_many :ingredients, MealprepBackend.V1.Ingredient

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
