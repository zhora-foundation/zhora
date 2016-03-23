defmodule Zhora.MetricRepo do
  use Zhora.Web, :repo

  alias Zhora.Metric

  def group_by_time(n, :hours), do: group_by_seconds(n * 60 * 60)
  def group_by_time(n, :minutes), do: group_by_seconds(n * 60)

  def group_by_seconds(seconds) do
    %RethinkDB.Record{data: data} =
      Metric.table_name
      |> table
      |> group(lambda(fn m ->
          ts = to_epoch_time(m["inserted_at"])
          sub(ts, mod(ts, seconds))
         end))
      |> Repo.run

    data
  end
end
