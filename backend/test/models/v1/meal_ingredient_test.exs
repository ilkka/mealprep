defmodule MealprepBackend.V1.MealIngredientTest do
  use MealprepBackend.ModelCase

  alias MealprepBackend.V1.MealIngredient

  @valid_attrs %{amount: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = MealIngredient.changeset(%MealIngredient{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = MealIngredient.changeset(%MealIngredient{}, @invalid_attrs)
    refute changeset.valid?
  end
end
