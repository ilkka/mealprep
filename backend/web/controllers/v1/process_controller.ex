defmodule MealprepBackend.V1.ProcessController do
  use MealprepBackend.Web, :controller

  alias MealprepBackend.V1.Process

  plug :scrub_params, "process" when action in [:create, :update]

  def index(conn, _params) do
    processes = Repo.all(Process)
    render(conn, "index.json", processes: processes)
  end

  def create(conn, %{"process" => process_params}) do
    changeset = Process.changeset(%Process{}, process_params)

    case Repo.insert(changeset) do
      {:ok, process} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_process_path(conn, :show, process))
        |> render("show.json", process: process)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(MealprepBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    process = Repo.get!(Process, id)
    render(conn, "show.json", process: process)
  end

  def update(conn, %{"id" => id, "process" => process_params}) do
    process = Repo.get!(Process, id)
    changeset = Process.changeset(process, process_params)

    case Repo.update(changeset) do
      {:ok, process} ->
        render(conn, "show.json", process: process)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(MealprepBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    process = Repo.get!(Process, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(process)

    send_resp(conn, :no_content, "")
  end
end
