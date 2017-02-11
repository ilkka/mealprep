defmodule MealprepBackend.V1.Component do
  use MealprepBackend.Web, :model

  schema "components" do
    field :name, :string
    field :thscode, :string
    field :visible, :boolean

    belongs_to :unit, MealprepBackend.V1.Unit
    belongs_to :componentclass, MealprepBackend.V1.ComponentClass

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
