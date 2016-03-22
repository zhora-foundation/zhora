defmodule Zhora.V1.MetricsController do
  use Zhora.Web, :controller
  alias Zhora.{Metric, MetricsParser}

  def create(conn, %{"metrics" => metrics} = params) do
    {status, json} =
      case MetricsParser.parse(metrics) do
        {:error, reason} ->
          {422, %{"error" => reason}}
        parsed_metrics ->
          create_metrics(conn.assigns.project,
            %{params | "metrics" => parsed_metrics})

          {200, %{"status" => "OK"}}
      end

    conn
    |> put_status(status)
    |> json(json)
  end

  def create(conn, _params) do
    conn
    |> put_status(400)
    |> json(%{"error" => "empty payload"})
  end

  defp create_metrics(project, params) do
    build_assoc(project, :metrics)
    |> Metric.changeset(params)
    |> Repo.insert
  end
end
