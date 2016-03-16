defmodule Zhora.V1.PingController do
  use Zhora.Web, :controller

  alias Zhora.ApiKey

  plug Zhora.AuthKeyPlug,
    error: {200, %{error: "Invalid API key", features: %{}, limit: 0}}

  def create(conn, _params) do
    conn
    |> put_status(200)
    |> render("success.json")
  end
end
