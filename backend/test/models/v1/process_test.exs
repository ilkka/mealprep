defmodule MealprepBackend.V1.ProcessTest do
  use MealprepBackend.ModelCase

  alias MealprepBackend.V1.Process

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Process.changeset(%Process{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Process.changeset(%Process{}, @invalid_attrs)
    refute changeset.valid?
  end
end
