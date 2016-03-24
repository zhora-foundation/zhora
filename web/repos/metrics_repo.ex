defmodule Zhora.MetricsRepo do
  use Zhora.Web, :repo
  alias Zhora.Metric

  def init, do: table(Metric.table_name)

  def run(query) do
    case Repo.run(query) do
      %RethinkDB.Record{data: data} -> data
      %RethinkDB.Collection{data: data} -> data
    end
  end

  def by_project(query, project_id), do: filter(query, %{project_id: project_id})

  def group_by_time(query, n, :hours), do: group_by_seconds(query, n * 60 * 60)
  def group_by_time(query, n, :minutes), do: group_by_seconds(query, n * 60)

  def group_by_seconds(query, seconds) do
    group(query, lambda(fn m ->
      ts = to_epoch_time(m["inserted_at"])
      sub(ts, mod(ts, seconds))
    end))
  end
end
