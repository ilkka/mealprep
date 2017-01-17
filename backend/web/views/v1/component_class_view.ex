defmodule MealprepBackend.V1.ComponentClassView do
  use MealprepBackend.Web, :view

  def render("index.json", %{componentclasses: componentclasses}) do
    render_many(componentclasses, MealprepBackend.V1.ComponentClassView, "component_class.json")
  end

  def render("show.json", %{component_class: component_class}) do
    render_one(component_class, MealprepBackend.V1.ComponentClassView, "component_class.json")
  end

  def render("component_class.json", %{component_class: component_class}) do
    %{id: component_class.id,
      name: component_class.name,
      thscode: component_class.thscode}
  end
end
