defmodule Zhora.AuthKeyPlug do
  import Plug.Conn

  alias Zhora.{Repo, Project}

  def init(opts) do
    opts[:error] || {403, %{error: "Invalid API key"}}
  end

  def call(conn, opts) do
    project = case get_req_header(conn, "x-api-key") do
      []    -> nil
      [key] -> Repo.get_by(Project, api_key: key)
    end

    case project do
      nil  -> render_error(conn, opts)
      _key -> assign(conn, project)
    end
  end

  defp assign(conn, project) do
     %{conn | assigns: Map.put(conn.assigns, :project, project)}
  end

  defp render_error(conn, {status, json}) do
    conn
    |> put_resp_content_type("application/json", "utf-8")
    |> send_resp(status, Poison.encode!(json))
    |> halt
  end
end
