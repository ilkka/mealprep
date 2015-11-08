defmodule MealprepBackend.V1.UnitControllerTest do
  use MealprepBackend.ConnCase

  alias MealprepBackend.V1.Unit
  @valid_attrs %{name: "some content", thscode: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_unit_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    unit = Repo.insert! %Unit{}
    conn = get conn, v1_unit_path(conn, :show, unit)
    assert json_response(conn, 200)["data"] == %{"id" => unit.id,
      "name" => unit.name,
      "thscode" => unit.thscode}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, v1_unit_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_unit_path(conn, :create), unit: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Unit, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_unit_path(conn, :create), unit: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    unit = Repo.insert! %Unit{}
    conn = put conn, v1_unit_path(conn, :update, unit), unit: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Unit, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    unit = Repo.insert! %Unit{}
    conn = put conn, v1_unit_path(conn, :update, unit), unit: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    unit = Repo.insert! %Unit{}
    conn = delete conn, v1_unit_path(conn, :delete, unit)
    assert response(conn, 204)
    refute Repo.get(Unit, unit.id)
  end
end
