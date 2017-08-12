defmodule MealprepWeb.FoodUnitControllerTest do
  use MealprepWeb.ConnCase

  alias Mealprep.Nutrition

  @create_attrs %{thscode: "some thscode"}
  @update_attrs %{thscode: "some updated thscode"}
  @invalid_attrs %{thscode: nil}

  def fixture(:food_unit) do
    {:ok, food_unit} = Nutrition.create_food_unit(@create_attrs)
    food_unit
  end

  describe "index" do
    test "lists all food_units", %{conn: conn} do
      conn = get conn, food_unit_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Food Units"
    end
  end

  describe "new food_unit" do
    test "renders form", %{conn: conn} do
      conn = get conn, food_unit_path(conn, :new)
      assert html_response(conn, 200) =~ "New Food Unit"
    end
  end

  describe "create food_unit" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, food_unit_path(conn, :create), food_unit: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == food_unit_path(conn, :show, id)

      conn = get conn, food_unit_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Food unit"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, food_unit_path(conn, :create), food_unit: @invalid_attrs
      assert html_response(conn, 200) =~ "New Food unit"
    end
  end

  describe "edit food_unit" do
    setup [:create_food_unit]

    test "renders form for editing chosen food_unit", %{conn: conn, food_unit: food_unit} do
      conn = get conn, food_unit_path(conn, :edit, food_unit)
      assert html_response(conn, 200) =~ "Edit Food unit"
    end
  end

  describe "update food_unit" do
    setup [:create_food_unit]

    test "redirects when data is valid", %{conn: conn, food_unit: food_unit} do
      conn = put conn, food_unit_path(conn, :update, food_unit), food_unit: @update_attrs
      assert redirected_to(conn) == food_unit_path(conn, :show, food_unit)

      conn = get conn, food_unit_path(conn, :show, food_unit)
      assert html_response(conn, 200) =~ "some updated thscode"
    end

    test "renders errors when data is invalid", %{conn: conn, food_unit: food_unit} do
      conn = put conn, food_unit_path(conn, :update, food_unit), food_unit: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Food unit"
    end
  end

  describe "delete food_unit" do
    setup [:create_food_unit]

    test "deletes chosen food_unit", %{conn: conn, food_unit: food_unit} do
      conn = delete conn, food_unit_path(conn, :delete, food_unit)
      assert redirected_to(conn) == food_unit_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, food_unit_path(conn, :show, food_unit)
      end
    end
  end

  defp create_food_unit(_) do
    food_unit = fixture(:food_unit)
    {:ok, food_unit: food_unit}
  end
end
