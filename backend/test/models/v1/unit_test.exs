defmodule MealprepBackend.V1.UnitTest do
  use MealprepBackend.ModelCase

  alias MealprepBackend.V1.Unit

  @valid_attrs %{name: "some content", thscode: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Unit.changeset(%Unit{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Unit.changeset(%Unit{}, @invalid_attrs)
    refute changeset.valid?
  end
end
