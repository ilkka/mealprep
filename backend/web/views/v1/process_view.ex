defmodule MealprepBackend.V1.ProcessView do
  use MealprepBackend.Web, :view

  def render("index.json", %{processes: processes}) do
    %{data: render_many(processes, MealprepBackend.V1.ProcessView, "process.json")}
  end

  def render("show.json", %{process: process}) do
    %{data: render_one(process, MealprepBackend.V1.ProcessView, "process.json")}
  end

  def render("process.json", %{process: process}) do
    %{id: process.id,
      name: process.name}
  end
end
