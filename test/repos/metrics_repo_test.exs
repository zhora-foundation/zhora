defmodule Zhora.MetricsRepoTest do
  use Zhora.ModelCase
  alias Zhora.{MetricsRepo, DataFactory}

  setup_all do
    project = DataFactory.create(:project)

    for n <- 0..59, rem(n, 3) == 0 do
      DataFactory.create(:metric,
        %{
          project: project,
          inserted_at: Ecto.DateTime.from_erl({{2016, 3, 23}, {10, n, 00}})
        })
    end

    {:ok, %{project: project}}
  end

  test "by_project", %{project: project} do
    result =
      MetricsRepo.init
      |> MetricsRepo.by_project(project.id)
      |> MetricsRepo.run
      |> Enum.map(&(&1["project_id"]))
      |> Enum.uniq

    assert result == [project.id]
  end

  test "group_by_time(10, :minutes)" do
    result =
      MetricsRepo.init
      |> MetricsRepo.group_by_time(10, :minutes)
      |> MetricsRepo.run

    assert Map.keys(result) == [1458727200, 1458727800, 1458728400,
                                1458729000, 1458729600, 1458730200]
  end

  test "group_by_seconds(900)" do
    result =
      MetricsRepo.init
      |> MetricsRepo.group_by_seconds(900)
      |> MetricsRepo.run

    assert Map.keys(result) == [1458727200, 1458728100,
                                1458729000, 1458729900]
  end
end
