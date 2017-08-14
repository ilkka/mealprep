defmodule Mealprep.Nutrition do
  @moduledoc """
  The Nutrition context.
  """

  import Ecto.Query, warn: false
  alias Mealprep.Repo

  alias Mealprep.Nutrition.{
    FoodUnit,
    FoodUnitTr
  }

  # True if translation is for a language with an ietf tag of lang.
  defp has_lang(translation, lang) do
    translation.language.ietfTag == lang
  end

  # Localize unit to given language. Assumes translations preloaded.
  defp localize_food_unit(unit, lang) do
    with %FoodUnit{food_unit_trs: trs} <- unit,
         %FoodUnitTr{description: desc} <- Enum.find(trs, nil, &(has_lang(&1, lang))) do
      %{unit | description: desc}
    else
      nil -> %{unit | description: unit.thscode}
    end
  end

  @doc """
  Returns the list of food_units. The results will
  be localized according to the lang parameter, which should
  be an IETF language tag. All available localisations are present
  and accessible through the food_unit_trs field.

  ## Examples

      iex> list_food_units("sv-FI")
      [%FoodUnit{}, ...]

  """
  def list_food_units(lang) do
    Repo.all(FoodUnit)
    |> Repo.preload([food_unit_trs: [:language]])
    |> Enum.map(&(localize_food_unit(&1, lang)))
  end

  @doc """
  Gets a single food_unit.

  Raises `Ecto.NoResultsError` if the Food unit does not exist.

  ## Examples

      iex> get_food_unit!(123, "fi-FI")
      %FoodUnit{}

      iex> get_food_unit!(456, "sv-FI")
      ** (Ecto.NoResultsError)

  """
  def get_food_unit!(id, lang) do
    Repo.get!(FoodUnit, id)
    |> Repo.preload([food_unit_trs: [:language]])
    |> localize_food_unit(lang)
  end

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
