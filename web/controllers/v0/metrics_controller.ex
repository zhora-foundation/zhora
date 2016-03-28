defmodule Zhora.V0.MetricsController do
  use Zhora.Web, :controller
  alias Zhora.{Metric, MetricsRepo}

  def index(conn, %{"project_id" => id, "interval" => interval}) do
    metrics =
      MetricsRepo.init
      |> MetricsRepo.by_project(id)
      |> MetricsRepo.group_by_time(interval, :minutes)
      |> MetricsRepo.run
      |> MetricsRepo.stringify_keys
      |> Map.new

    conn
    |> put_status(200)
    |> render("index.json", metrics: metrics)
  end

  def index(conn, _params) do
    conn
    |> put_status(400)
    |> render("index.json", error: "`project_id` or `interval` is missing")
  end
end
