defmodule MealprepBackend.V1.ComponentClassController do
  use MealprepBackend.Web, :controller

  alias MealprepBackend.V1.ComponentClass

  plug :scrub_params, "component_class" when action in [:create, :update]

  def index(conn, _params) do
    componentclasses = Repo.all(ComponentClass)
    render(conn, "index.json", componentclasses: componentclasses)
  end

  def create(conn, %{"component_class" => component_class_params}) do
    changeset = ComponentClass.changeset(%ComponentClass{}, component_class_params)

    case Repo.insert(changeset) do
      {:ok, component_class} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_component_class_path(conn, :show, component_class))
        |> render("show.json", component_class: component_class)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(MealprepBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    component_class = Repo.get!(ComponentClass, id)
    render(conn, "show.json", component_class: component_class)
  end

  def update(conn, %{"id" => id, "component_class" => component_class_params}) do
    component_class = Repo.get!(ComponentClass, id)
    changeset = ComponentClass.changeset(component_class, component_class_params)

    case Repo.update(changeset) do
      {:ok, component_class} ->
        render(conn, "show.json", component_class: component_class)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(MealprepBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    component_class = Repo.get!(ComponentClass, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(component_class)

    send_resp(conn, :no_content, "")
  end
end
