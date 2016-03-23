defmodule Zhora.DataFactory do
  use ExMachina.Ecto, repo: Zhora.Repo

  def factory(:project) do
    %Zhora.Project{
      name: "zhora test",
      api_key: "validkey"
    }
  end

  def factory(:metric) do
    %Zhora.Metric{
      project: build(:project),
      environment: "production",
      hostname: "zhora.hoster",
      metrics: metrics
    }
  end

  defp metrics do
    %{
      "app.request.200" => %{
        "count" => 1.0, "max" => 13.554, "mean" => 13.554,
        "median" => 13.554, "min" => 13.554, "percentile_90" => 13.554
      }
    }
  end
end
