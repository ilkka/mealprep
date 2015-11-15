defmodule MealprepBackend.V1.IngredientView do
  use MealprepBackend.Web, :view
  alias MealprepBackend.V1.ProcessView
  alias MealprepBackend.V1.IngredientClassView
  alias MealprepBackend.V1.ComponentValueView

  @attributes ~w(id name edible_portion inserted_at updated_at)a

  def render("index.json", %{ingredients: ingredients}) do
    %{data: render_many(ingredients, MealprepBackend.V1.IngredientView, "ingredient.json")}
  end

  def render("show.json", %{ingredient: ingredient}) do
    %{data: render_one(ingredient, MealprepBackend.V1.IngredientView, "ingredient.json")}
  end

  def render("ingredient.json", %{ingredient: ingredient}) do
    ingredient
    |> Map.take(@attributes)
    |> Map.put(:process, ProcessView.render("process.json", process: ingredient.process))
    |> Map.put(:class, IngredientClassView.render("ingredient_class.json", ingredient_class: ingredient.ingredientclass))
    |> Map.put(:components, Enum.map(ingredient.components,
          fn(c) -> ComponentValueView.render("component_value_in_ingredient.json", component_value: c)
          end))
  end
end
