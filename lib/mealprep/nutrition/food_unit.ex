defmodule Mealprep.Nutrition.FoodUnit do
  use Ecto.Schema
  import Ecto.Changeset
  alias Mealprep.Nutrition.FoodUnit


  schema "foodunits" do
    field :thscode, :string

    timestamps()
  end

  @doc false
  def changeset(%FoodUnit{} = food_unit, attrs) do
    food_unit
    |> cast(attrs, [:thscode])
    |> validate_required([:thscode])
  end
end
