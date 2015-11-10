defmodule MealprepBackend.V1.ComponentValueController do
  use MealprepBackend.Web, :controller

  alias MealprepBackend.V1.ComponentValue

  plug :scrub_params, "component_value" when action in [:create, :update]

  def index(conn, _params) do
    componentvalues = Repo.all(ComponentValue)
    render(conn, "index.json", componentvalues: componentvalues)
  end

  def create(conn, %{"component_value" => component_value_params}) do
    changeset = ComponentValue.changeset(%ComponentValue{}, component_value_params)

    case Repo.insert(changeset) do
      {:ok, component_value} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_component_value_path(conn, :show, component_value))
        |> render("show.json", component_value: component_value)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(MealprepBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    component_value = Repo.get!(ComponentValue, id)
    render(conn, "show.json", component_value: component_value)
  end

  def update(conn, %{"id" => id, "component_value" => component_value_params}) do
    component_value = Repo.get!(ComponentValue, id)
    changeset = ComponentValue.changeset(component_value, component_value_params)

    case Repo.update(changeset) do
      {:ok, component_value} ->
        render(conn, "show.json", component_value: component_value)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(MealprepBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    component_value = Repo.get!(ComponentValue, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(component_value)

    send_resp(conn, :no_content, "")
  end
end
