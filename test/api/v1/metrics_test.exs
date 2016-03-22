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

  test "POST /v1/metrics with valid metrics", %{conn: conn, project: project} do
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

    assert json_response(conn, 200) == %{"status" => "OK"}

    metrics = Repo.all(assoc(project, :metrics))
    metric = List.first(metrics)

    assert length(metrics) == 1
    assert metric.environment == "production"
    assert metric.hostname == "zhora.hoster"
    assert metric.metrics == %{
      "app.request.200" => %{
        "count" => 1, "mean" => 13.554, "median" => 13.554,
        "percentile_90" => 13.554, "min" => 13.554, "max" => 13.554
      }
    }
  end

  test "POST /v1/metrics with invalid metrics", %{conn: conn, project: project} do
    json =
      %{metrics: ["users what"],
        environment: "production",
        hostname: "zhora.hoster"}

    conn =
      conn
      |> put_req_header("x-api-key", "validkey")
      |> put_req_header("accept", "application/json")
      |> put_req_header("content-type", "application/json")
      |> put_req_header("content-encoding", "deflate")
      |> post("/v1/metrics", deflate_json(json))

    assert json_response(conn, 422) == %{"error" => "malformed value"}
    assert length(Repo.all(assoc(project, :metrics))) == 0
  end

  test "POST /v1/metrics without payload", %{conn: conn, project: project} do
    conn =
      conn
      |> put_req_header("x-api-key", "validkey")
      |> put_req_header("accept", "application/json")
      |> put_req_header("content-type", "application/json")
      |> put_req_header("content-encoding", "deflate")
      |> post("/v1/metrics", deflate_json(%{}))

    assert json_response(conn, 400) == %{"error" => "empty payload"}
    assert length(Repo.all(assoc(project, :metrics))) == 0
  end
end
