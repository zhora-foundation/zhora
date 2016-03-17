defmodule Zhora.V1.DeploysController do
  use Zhora.Web, :controller

  alias Zhora.Deploy

  def create(conn, params) do
    params = Map.put(params, "project_id", conn.assigns.project.id)

    build_assoc(conn.assigns.project, :deploys)
    |> Deploy.changeset(params)
    |> Repo.insert

    conn
    |> put_status(201)
    |> json(%{status: "OK"})
  end
end
