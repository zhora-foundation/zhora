defmodule Zhora.MetricsRepoTest do
  use Zhora.ModelCase
  alias Zhora.{MetricsRepo, DataFactory}

  setup_all do
    project = DataFactory.create(:project)

    ts1 = Ecto.DateTime.from_erl({{2016, 3, 23}, {10, 33, 10}})
    ts2 = Ecto.DateTime.from_erl({{2016, 3, 23}, {10, 54, 19}})
    ts3 = Ecto.DateTime.from_erl({{2016, 3, 24}, {12, 13, 11}})

    DataFactory.create(:metric, %{project: project, inserted_at: ts1})
    DataFactory.create(:metric, %{project: project, inserted_at: ts2})
    DataFactory.create(:metric, %{inserted_at: ts3})

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

    assert Map.keys(result) == [1458729000, 1458730200, 1458821400]
  end

  test "group_by_time(3, :minutes)" do
    result =
      MetricsRepo.init
      |> MetricsRepo.group_by_time(3, :minutes)
      |> MetricsRepo.run

    assert Map.keys(result) == [1458729180, 1458730440, 1458821520]
  end
end
