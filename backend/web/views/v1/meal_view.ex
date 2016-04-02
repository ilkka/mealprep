defmodule MealprepBackend.V1.MealView do
  use MealprepBackend.Web, :view
  alias MealprepBackend.V1.IngredientView

  def render("index.json", %{meals: meals}) do
    %{data: render_many(meals, MealprepBackend.V1.MealView, "meal.json")}
  end

  def render("show.json", %{meal: meal}) do
    %{data: render_one(meal, MealprepBackend.V1.MealView, "meal_full.json")}
  end

  def render("meal.json", %{meal: meal}) do
    %{id: meal.id,
      name: meal.name}
  end

  def render("meal_full.json", %{meal: meal}) do
    %{id: meal.id,
      name: meal.name}
      |> Map.put(:ingredients, Enum.map(meal.ingredients,
          fn(i) ->
            IngredientView.render("ingredient.json", i)
            |> Map.put(:amount, i.amount)
          end))
  end
end
