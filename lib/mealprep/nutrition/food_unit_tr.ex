defmodule Mealprep.Nutrition.FoodUnitTr do
  use Ecto.Schema
  import Ecto.Changeset
  alias Mealprep.Nutrition.{FoodUnit, FoodUnitTr}

  schema "food_unit_trs" do
    field :description, :string
    field :language_id, :id
    belongs_to :food_unit, FoodUnit

    timestamps()
  end

  @doc false
  def changeset(%FoodUnitTr{} = food_unit_tr, attrs) do
    food_unit_tr
    |> cast(attrs, [:description])
    |> validate_required([:description])
  end
end
