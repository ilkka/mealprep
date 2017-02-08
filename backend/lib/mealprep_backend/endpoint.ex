defmodule MealprepBackend.Endpoint do
  use Phoenix.Endpoint, otp_app: :mealprep_backend

  socket "/socket", MealprepBackend.UserSocket

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/", from: :mealprep_backend, gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt static index.html)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_mealprep_backend_key",
    signing_salt: "7ygeXNt2"

  plug CORSPlug
  plug MealprepBackend.Router
end
