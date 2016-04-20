defmodule Zhora.V1.NoticesController do
  use Zhora.Web, :controller
  alias Zhora.Notice

  def create(conn, params) do
    params = Map.put(params, "project_id", conn.assigns.project.id)

    notice =
      build_assoc(conn.assigns.project, :notices)
      |> Notice.changeset(params)
      |> Repo.insert
      |> respond_result(conn)
  end

  defp respond_result({:ok, notice}, conn) do
    conn
    |> put_status(200)
    |> put_resp_header("x-uuid", notice.id)
    |> json(%{id: notice.id})
  end

  defp respond_result({:error, changeset}, conn) do
    conn
    |> put_status(400)
    |> json(%{error: "malformed value"})
  end
end
