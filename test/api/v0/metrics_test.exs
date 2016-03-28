defmodule Zhora.ApiV0MetricsTest do
  use Zhora.ConnCase
  alias Zhora.{Metric, DataFactory}

  @no_params_error "`project_id` or `interval` is missing"

  setup do
    project = DataFactory.create(:project)

    for n <- 0..59, rem(n, 3) == 0 do
      DataFactory.create(:metric,
        %{
          project: project,
          inserted_at: Ecto.DateTime.from_erl({{2016, 3, 23}, {10, n, 00}})
        })
    end

    on_exit fn ->
      Repo.delete(project)
      Repo.delete_all(Metric)
    end

    {:ok, %{project: project}}
  end

  test "GET /v0/metrics with project_id and interval", %{project: project} do
    conn = get(conn, "/v0/metrics", project_id: project.id, interval: 30)
    body = json_response(conn, 200)

    assert Map.keys(body["metrics"]) == ["1458727200", "1458729000"]
  end

  test "GET /v0/metrics without params" do
    conn = get(conn, "/v0/metrics")

    assert json_response(conn, 400) == %{"status" => "error", "reason" => @no_params_error}
  end

  test "GET /v0/metrics with project_id", %{project: project} do
    conn = get(conn, "/v0/metrics", project_id: project.id)

    assert json_response(conn, 400) == %{"status" => "error", "reason" => @no_params_error}
  end

  test "GET /v0/metrics with interval" do
    conn = get(conn, "/v0/metrics", interval: 10)

    assert json_response(conn, 400) == %{"status" => "error", "reason" => @no_params_error}
  end
end
