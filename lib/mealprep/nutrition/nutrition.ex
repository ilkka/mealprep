defmodule Mealprep.Nutrition do
  @moduledoc """
  The Nutrition context.
  """

  import Ecto.Query, warn: false
  alias Mealprep.Repo

  alias Mealprep.Nutrition.FoodUnit

  @doc """
  Returns the list of food_units.

  ## Examples

      iex> list_food_units()
      [%FoodUnit{}, ...]

  """
  def list_food_units do
    Repo.all(FoodUnit)
  end

  @doc """
  Gets a single food_unit.

  Raises `Ecto.NoResultsError` if the Food unit does not exist.

  ## Examples

      iex> get_food_unit!(123)
      %FoodUnit{}

      iex> get_food_unit!(456)
      ** (Ecto.NoResultsError)

  """
  def get_food_unit!(id), do: Repo.get!(FoodUnit, id)

  @doc """
  Creates a food_unit.

  ## Examples

      iex> create_food_unit(%{field: value})
      {:ok, %FoodUnit{}}

      iex> create_food_unit(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_food_unit(attrs \\ %{}) do
    %FoodUnit{}
    |> FoodUnit.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a food_unit.

  ## Examples

      iex> update_food_unit(food_unit, %{field: new_value})
      {:ok, %FoodUnit{}}

      iex> update_food_unit(food_unit, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_food_unit(%FoodUnit{} = food_unit, attrs) do
    food_unit
    |> FoodUnit.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a FoodUnit.

  ## Examples

      iex> delete_food_unit(food_unit)
      {:ok, %FoodUnit{}}

      iex> delete_food_unit(food_unit)
      {:error, %Ecto.Changeset{}}

  """
  def delete_food_unit(%FoodUnit{} = food_unit) do
    Repo.delete(food_unit)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking food_unit changes.

  ## Examples

      iex> change_food_unit(food_unit)
      %Ecto.Changeset{source: %FoodUnit{}}

  """
  def change_food_unit(%FoodUnit{} = food_unit) do
    FoodUnit.changeset(food_unit, %{})
  end
end
