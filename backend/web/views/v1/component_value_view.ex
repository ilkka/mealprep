defmodule MealprepBackend.V1.ComponentValueView do
  use MealprepBackend.Web, :view

  def render("index.json", %{componentvalues: componentvalues}) do
    %{data: render_many(componentvalues, MealprepBackend.V1.ComponentValueView, "component_value.json")}
  end

  def render("show.json", %{component_value: component_value}) do
    %{data: render_one(component_value, MealprepBackend.V1.ComponentValueView, "component_value.json")}
  end

  def render("component_value.json", %{component_value: component_value}) do
    %{id: component_value.id,
      name: component_value.component.name,
      value: component_value.value}
  end
end
