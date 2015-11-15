defmodule MealprepBackend.V1.ComponentControllerTest do
  use MealprepBackend.ConnCase

  alias MealprepBackend.V1.Component
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_component_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    component = Repo.insert! %Component{}
    conn = get conn, v1_component_path(conn, :show, component)
    assert json_response(conn, 200)["data"] == %{"id" => component.id,
      "name" => component.name}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, v1_component_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_component_path(conn, :create), component: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Component, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_component_path(conn, :create), component: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    component = Repo.insert! %Component{}
    conn = put conn, v1_component_path(conn, :update, component), component: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Component, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    component = Repo.insert! %Component{}
    conn = put conn, v1_component_path(conn, :update, component), component: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    component = Repo.insert! %Component{}
    conn = delete conn, v1_component_path(conn, :delete, component)
    assert response(conn, 204)
    refute Repo.get(Component, component.id)
  end
end