defmodule MealprepBackend.V1.ComponentClassControllerTest do
  use MealprepBackend.ConnCase

  alias MealprepBackend.V1.ComponentClass
  @valid_attrs %{name: "some content", thscode: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_component_class_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    component_class = Repo.insert! %ComponentClass{}
    conn = get conn, v1_component_class_path(conn, :show, component_class)
    assert json_response(conn, 200)["data"] == %{"id" => component_class.id,
      "name" => component_class.name,
      "thscode" => component_class.thscode}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, v1_component_class_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_component_class_path(conn, :create), component_class: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(ComponentClass, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_component_class_path(conn, :create), component_class: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    component_class = Repo.insert! %ComponentClass{}
    conn = put conn, v1_component_class_path(conn, :update, component_class), component_class: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(ComponentClass, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    component_class = Repo.insert! %ComponentClass{}
    conn = put conn, v1_component_class_path(conn, :update, component_class), component_class: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    component_class = Repo.insert! %ComponentClass{}
    conn = delete conn, v1_component_class_path(conn, :delete, component_class)
    assert response(conn, 204)
    refute Repo.get(ComponentClass, component_class.id)
  end
end
