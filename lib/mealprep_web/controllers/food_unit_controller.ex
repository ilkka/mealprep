defmodule MealprepWeb.FoodUnitController do
  use MealprepWeb, :controller

  alias Mealprep.Nutrition
  alias Mealprep.Nutrition.FoodUnit

  def index(conn, _params) do
    foodunits = Nutrition.list_foodunits()
    render(conn, "index.html", foodunits: foodunits)
  end

  def new(conn, _params) do
    changeset = Nutrition.change_food_unit(%FoodUnit{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"food_unit" => food_unit_params}) do
    case Nutrition.create_food_unit(food_unit_params) do
      {:ok, food_unit} ->
        conn
        |> put_flash(:info, "Food unit created successfully.")
        |> redirect(to: food_unit_path(conn, :show, food_unit))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    food_unit = Nutrition.get_food_unit!(id)
    render(conn, "show.html", food_unit: food_unit)
  end

  def edit(conn, %{"id" => id}) do
    food_unit = Nutrition.get_food_unit!(id)
    changeset = Nutrition.change_food_unit(food_unit)
    render(conn, "edit.html", food_unit: food_unit, changeset: changeset)
  end

  def update(conn, %{"id" => id, "food_unit" => food_unit_params}) do
    food_unit = Nutrition.get_food_unit!(id)

    case Nutrition.update_food_unit(food_unit, food_unit_params) do
      {:ok, food_unit} ->
        conn
        |> put_flash(:info, "Food unit updated successfully.")
        |> redirect(to: food_unit_path(conn, :show, food_unit))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", food_unit: food_unit, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    food_unit = Nutrition.get_food_unit!(id)
    {:ok, _food_unit} = Nutrition.delete_food_unit(food_unit)

    conn
    |> put_flash(:info, "Food unit deleted successfully.")
    |> redirect(to: food_unit_path(conn, :index))
  end
end
