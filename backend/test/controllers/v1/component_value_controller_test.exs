defmodule MealprepBackend.V1.ComponentValueControllerTest do
  use MealprepBackend.ConnCase

  alias MealprepBackend.V1.ComponentValue
  @valid_attrs %{value: "120.5"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_component_value_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    component_value = Repo.insert! %ComponentValue{}
    conn = get conn, v1_component_value_path(conn, :show, component_value)
    assert json_response(conn, 200)["data"] == %{"id" => component_value.id,
      "value" => component_value.value}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, v1_component_value_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_component_value_path(conn, :create), component_value: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(ComponentValue, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_component_value_path(conn, :create), component_value: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    component_value = Repo.insert! %ComponentValue{}
    conn = put conn, v1_component_value_path(conn, :update, component_value), component_value: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(ComponentValue, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    component_value = Repo.insert! %ComponentValue{}
    conn = put conn, v1_component_value_path(conn, :update, component_value), component_value: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    component_value = Repo.insert! %ComponentValue{}
    conn = delete conn, v1_component_value_path(conn, :delete, component_value)
    assert response(conn, 204)
    refute Repo.get(ComponentValue, component_value.id)
  end
end
