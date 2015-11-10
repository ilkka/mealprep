defmodule MealprepBackend.V1.ComponentTest do
  use MealprepBackend.ModelCase

  alias MealprepBackend.V1.Component

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Component.changeset(%Component{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Component.changeset(%Component{}, @invalid_attrs)
    refute changeset.valid?
  end
end
