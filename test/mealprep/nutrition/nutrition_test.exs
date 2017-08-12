defmodule Mealprep.NutritionTest do
  use Mealprep.DataCase

  alias Mealprep.Nutrition

  describe "food_units" do
    alias Mealprep.Nutrition.FoodUnit

    @valid_attrs %{thscode: "some thscode"}
    @update_attrs %{thscode: "some updated thscode"}
    @invalid_attrs %{thscode: nil}

    def food_unit_fixture(attrs \\ %{}) do
      {:ok, food_unit} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Nutrition.create_food_unit()

      food_unit
    end

    test "list_food_units/0 returns all food_units" do
      food_unit = food_unit_fixture()
      assert Nutrition.list_food_units() == [food_unit]
    end

    test "get_food_unit!/1 returns the food_unit with given id" do
      food_unit = food_unit_fixture()
      assert Nutrition.get_food_unit!(food_unit.id) == food_unit
    end

    test "create_food_unit/1 with valid data creates a food_unit" do
      assert {:ok, %FoodUnit{} = food_unit} = Nutrition.create_food_unit(@valid_attrs)
      assert food_unit.thscode == "some thscode"
    end

    test "create_food_unit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Nutrition.create_food_unit(@invalid_attrs)
    end

    test "update_food_unit/2 with valid data updates the food_unit" do
      food_unit = food_unit_fixture()
      assert {:ok, food_unit} = Nutrition.update_food_unit(food_unit, @update_attrs)
      assert %FoodUnit{} = food_unit
      assert food_unit.thscode == "some updated thscode"
    end

    test "update_food_unit/2 with invalid data returns error changeset" do
      food_unit = food_unit_fixture()
      assert {:error, %Ecto.Changeset{}} = Nutrition.update_food_unit(food_unit, @invalid_attrs)
      assert food_unit == Nutrition.get_food_unit!(food_unit.id)
    end

    test "delete_food_unit/1 deletes the food_unit" do
      food_unit = food_unit_fixture()
      assert {:ok, %FoodUnit{}} = Nutrition.delete_food_unit(food_unit)
      assert_raise Ecto.NoResultsError, fn -> Nutrition.get_food_unit!(food_unit.id) end
    end

    test "change_food_unit/1 returns a food_unit changeset" do
      food_unit = food_unit_fixture()
      assert %Ecto.Changeset{} = Nutrition.change_food_unit(food_unit)
    end
  end
end
