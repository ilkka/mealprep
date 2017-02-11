defmodule MealprepBackend.V1.ComponentClass do
  use MealprepBackend.Web, :model

  schema "componentclasses" do
    field :name, :string
    field :thscode, :string

    belongs_to :parent, MealprepBackend.V1.ComponentClass

    timestamps()
  end

  @required_fields ~w(name thscode)
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
