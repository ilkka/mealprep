defmodule MealprepBackend.V1.IngredientClassTest do
  use MealprepBackend.ModelCase

  alias MealprepBackend.V1.IngredientClass

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = IngredientClass.changeset(%IngredientClass{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = IngredientClass.changeset(%IngredientClass{}, @invalid_attrs)
    refute changeset.valid?
  end
end
