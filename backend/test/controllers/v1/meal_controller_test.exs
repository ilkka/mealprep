defmodule MealprepBackend.V1.MealControllerTest do
  use MealprepBackend.ConnCase

  alias MealprepBackend.V1.Meal
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_meal_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    meal = Repo.insert! %Meal{}
    conn = get conn, v1_meal_path(conn, :show, meal)
    assert json_response(conn, 200)["data"] == %{"id" => meal.id,
      "name" => meal.name}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, v1_meal_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_meal_path(conn, :create), meal: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Meal, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_meal_path(conn, :create), meal: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    meal = Repo.insert! %Meal{}
    conn = put conn, v1_meal_path(conn, :update, meal), meal: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Meal, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    meal = Repo.insert! %Meal{}
    conn = put conn, v1_meal_path(conn, :update, meal), meal: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    meal = Repo.insert! %Meal{}
    conn = delete conn, v1_meal_path(conn, :delete, meal)
    assert response(conn, 204)
    refute Repo.get(Meal, meal.id)
  end
end
