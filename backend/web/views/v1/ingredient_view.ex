defmodule MealprepBackend.V1.IngredientView do
  use MealprepBackend.Web, :view

  def render("index.json", %{ingredients: ingredients}) do
    %{data: render_many(ingredients, MealprepBackend.V1.IngredientView, "ingredient.json")}
  end

  def render("show.json", %{ingredient: ingredient}) do
    %{data: render_one(ingredient, MealprepBackend.V1.IngredientView, "ingredient.json")}
  end

  def render("ingredient.json", %{ingredient: ingredient}) do
    %{id: ingredient.id,
      name: ingredient.name}
  end
end
