defmodule MealprepBackend.V1.MealController do
  use MealprepBackend.Web, :controller

  alias MealprepBackend.V1.Meal

  plug :scrub_params, "meal" when action in [:create, :update]

  def index(conn, _params) do
    meals = Repo.all(Meal)
    render(conn, "index.json", meals: meals)
  end

  def create(conn, %{"meal" => meal_params}) do
    changeset = Meal.changeset(%Meal{}, meal_params)

    case Repo.insert(changeset) do
      {:ok, meal} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_meal_path(conn, :show, meal))
        |> render("show.json", meal: meal)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(MealprepBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    meal = Repo.get!(Meal, id)
      |> Repo.preload([ingredients: [ingredient: [:process, :ingredientclass, components: [component: :unit]]]])
    render(conn, "show.json", meal: meal)
  end

  def update(conn, %{"id" => id, "meal" => meal_params}) do
    meal = Repo.get!(Meal, id)
    changeset = Meal.changeset(meal, meal_params)

    case Repo.update(changeset) do
      {:ok, meal} ->
        render(conn, "show.json", meal: meal)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(MealprepBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    meal = Repo.get!(Meal, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(meal)

    send_resp(conn, :no_content, "")
  end
end
