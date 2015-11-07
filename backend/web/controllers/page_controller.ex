defmodule MealprepBackend.PageController do
  use MealprepBackend.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
