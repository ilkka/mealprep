defmodule MealprepBackend.V1.IngredientClassView do
  use MealprepBackend.Web, :view

  def render("index.json", %{ingredientclasses: ingredientclasses}) do
    render_many(ingredientclasses, MealprepBackend.V1.IngredientClassView, "ingredient_class.json")
  end

  def render("show.json", %{ingredient_class: ingredient_class}) do
    render_one(ingredient_class, MealprepBackend.V1.IngredientClassView, "ingredient_class.json")
  end

  def render("ingredient_class.json", %{ingredient_class: ingredient_class}) do
    %{id: ingredient_class.id,
      name: ingredient_class.name,
      parent_id: ingredient_class.parent_id}
  end
end
