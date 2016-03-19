defmodule Zhora.ApiV1MetricsTest do
  use Zhora.ConnCase

  alias Zhora.{Project, Metric}

  setup do
    project = Repo.insert!(%Project{name: "test", api_key: "validkey"})

    on_exit fn ->
      Repo.delete(project)
      Repo.delete_all(Metric)
    end

    {:ok, %{project: project}}
  end

  test "POST /v1/metrics", %{conn: conn} do
    json =
      %{metrics:
        ["app.request.200:mean 13.554",
         "app.request.200:median 13.554",
         "app.request.200:percentile_90 13.554",
         "app.request.200:min 13.554",
         "app.request.200:max 13.554",
         "app.request.200 1"],
        environment: "production",
        hostname: "zhora.hoster"}

    conn =
      conn
      |> put_req_header("x-api-key", "validkey")
      |> put_req_header("accept", "application/json")
      |> put_req_header("content-type", "application/json")
      |> put_req_header("content-encoding", "deflate")
      |> post("/v1/metrics", deflate_json(json))

    assert get_resp_header(conn, "content-type") == ["application/json; charset=utf-8"]
    assert conn.status == 200
    assert conn.resp_body == "OK"

    assert json_response(conn, 200) == %{}
  end
end
