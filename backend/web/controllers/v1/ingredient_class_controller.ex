defmodule MealprepBackend.V1.IngredientClassController do
  use MealprepBackend.Web, :controller

  alias MealprepBackend.V1.IngredientClass

  def index(conn, _params) do
    ingredientclasses = Repo.all(IngredientClass)
    render(conn, "index.json", ingredientclasses: ingredientclasses)
  end

  def create(conn, %{"ingredient_class" => ingredient_class_params}) do
    changeset = IngredientClass.changeset(%IngredientClass{}, ingredient_class_params)

    case Repo.insert(changeset) do
      {:ok, ingredient_class} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_ingredient_class_path(conn, :show, ingredient_class))
        |> render("show.json", ingredient_class: ingredient_class)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(MealprepBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    ingredient_class = Repo.get!(IngredientClass, id)
    render(conn, "show.json", ingredient_class: ingredient_class)
  end

  def update(conn, %{"id" => id, "ingredient_class" => ingredient_class_params}) do
    ingredient_class = Repo.get!(IngredientClass, id)
    changeset = IngredientClass.changeset(ingredient_class, ingredient_class_params)

    case Repo.update(changeset) do
      {:ok, ingredient_class} ->
        render(conn, "show.json", ingredient_class: ingredient_class)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(MealprepBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    ingredient_class = Repo.get!(IngredientClass, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(ingredient_class)

    send_resp(conn, :no_content, "")
  end
end
