defmodule MealprepBackend.V1.ComponentView do
  use MealprepBackend.Web, :view

  def render("index.json", %{components: components}) do
    render_many(components, MealprepBackend.V1.ComponentView, "component.json")
  end

  def render("show.json", %{component: component}) do
    render_one(component, MealprepBackend.V1.ComponentView, "component.json")
  end

  def render("component.json", %{component: component}) do
    %{id: component.id,
      name: component.name}
  end
end
