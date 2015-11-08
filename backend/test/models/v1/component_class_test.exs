defmodule MealprepBackend.V1.ComponentClassTest do
  use MealprepBackend.ModelCase

  alias MealprepBackend.V1.ComponentClass

  @valid_attrs %{name: "some content", thscode: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ComponentClass.changeset(%ComponentClass{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ComponentClass.changeset(%ComponentClass{}, @invalid_attrs)
    refute changeset.valid?
  end
end
