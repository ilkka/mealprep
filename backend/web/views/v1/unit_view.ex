defmodule MealprepBackend.V1.UnitView do
  use MealprepBackend.Web, :view

  def render("index.json", %{units: units}) do
    render_many(units, MealprepBackend.V1.UnitView, "unit.json")
  end

  def render("show.json", %{unit: unit}) do
    render_one(unit, MealprepBackend.V1.UnitView, "unit.json")
  end

  def render("unit.json", %{unit: unit}) do
    %{id: unit.id,
      name: unit.name,
      thscode: unit.thscode}
  end
end
