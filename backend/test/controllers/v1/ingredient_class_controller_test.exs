defmodule MealprepBackend.V1.IngredientClassControllerTest do
  use MealprepBackend.ConnCase

  alias MealprepBackend.V1.IngredientClass
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_ingredient_class_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    ingredient_class = Repo.insert! %IngredientClass{}
    conn = get conn, v1_ingredient_class_path(conn, :show, ingredient_class)
    assert json_response(conn, 200)["data"] == %{"id" => ingredient_class.id,
      "name" => ingredient_class.name}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, v1_ingredient_class_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_ingredient_class_path(conn, :create), ingredient_class: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(IngredientClass, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_ingredient_class_path(conn, :create), ingredient_class: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    ingredient_class = Repo.insert! %IngredientClass{}
    conn = put conn, v1_ingredient_class_path(conn, :update, ingredient_class), ingredient_class: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(IngredientClass, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    ingredient_class = Repo.insert! %IngredientClass{}
    conn = put conn, v1_ingredient_class_path(conn, :update, ingredient_class), ingredient_class: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    ingredient_class = Repo.insert! %IngredientClass{}
    conn = delete conn, v1_ingredient_class_path(conn, :delete, ingredient_class)
    assert response(conn, 204)
    refute Repo.get(IngredientClass, ingredient_class.id)
  end
end
