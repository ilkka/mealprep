defmodule MealprepBackend.FrontendController do
  use MealprepBackend.Web, :controller

  def index(conn, _params) do
    # redirect conn, to: "/index.html"
    conn
    |> put_resp_header("content-type", "text/html; charset=utf-8")
    |> Plug.Conn.send_file(200, "./priv/static/index.html")
  end
end
