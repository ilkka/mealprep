defmodule MealprepBackend.V1.ProcessControllerTest do
  use MealprepBackend.ConnCase

  alias MealprepBackend.V1.Process
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_process_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    process = Repo.insert! %Process{}
    conn = get conn, v1_process_path(conn, :show, process)
    assert json_response(conn, 200)["data"] == %{"id" => process.id,
      "name" => process.name}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, v1_process_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_process_path(conn, :create), process: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Process, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_process_path(conn, :create), process: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    process = Repo.insert! %Process{}
    conn = put conn, v1_process_path(conn, :update, process), process: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Process, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    process = Repo.insert! %Process{}
    conn = put conn, v1_process_path(conn, :update, process), process: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    process = Repo.insert! %Process{}
    conn = delete conn, v1_process_path(conn, :delete, process)
    assert response(conn, 204)
    refute Repo.get(Process, process.id)
  end
end
