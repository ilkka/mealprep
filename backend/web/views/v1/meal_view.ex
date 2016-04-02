defmodule MealprepBackend.V1.MealView do
  use MealprepBackend.Web, :view

  def render("index.json", %{meals: meals}) do
    %{data: render_many(meals, MealprepBackend.V1.MealView, "meal.json")}
  end

  def render("show.json", %{meal: meal}) do
    %{data: render_one(meal, MealprepBackend.V1.MealView, "meal.json")}
  end

  def render("meal.json", %{meal: meal}) do
    %{id: meal.id,
      name: meal.name}
  end
end
