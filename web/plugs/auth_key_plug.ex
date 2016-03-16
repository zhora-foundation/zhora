defmodule Zhora.AuthKeyPlug do
  import Plug.Conn

  def init(opts) do
    opts[:error] || {403, %{error: "Invalid API key"}}
  end

  def call(conn, opts) do
    api_key = case get_req_header(conn, "x-api-key") do
      []    -> nil
      [key] -> Zhora.Repo.get_by(Zhora.ApiKey, key: key)
    end

    case api_key do
      nil  -> render_error(conn, opts)
      _key -> conn
    end
  end

  defp render_error(conn, {status, json}) do
    conn
    |> put_resp_content_type("application/json", "utf-8")
    |> send_resp(status, Poison.encode!(json))
    |> halt
  end
end
