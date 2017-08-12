defmodule Mealprep.Nutrition.FoodUnit do
  use Ecto.Schema
  import Ecto.Changeset
  alias Mealprep.Nutrition.{FoodUnit, FoodUnitTr}


  schema "food_units" do
    field :thscode, :string
    has_many :food_unit_trs, FoodUnitTr

    timestamps()
  end

  @doc false
  def changeset(%FoodUnit{} = food_unit, attrs) do
    food_unit
    |> cast(attrs, [:thscode])
    |> validate_required([:thscode])
  end
end
