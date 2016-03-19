defmodule Zhora.V1.MetricsController do
  use Zhora.Web, :controller

  def create(conn, _params) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, "OK")
  end
end
