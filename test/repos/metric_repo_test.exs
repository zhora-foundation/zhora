defmodule Zhora.MetricRepoTest do
  use Zhora.ModelCase

  alias Zhora.{MetricRepo, DataFactory}

  setup_all do
    ts1 = Ecto.DateTime.from_erl({{2016, 3, 23}, {10, 33, 10}})
    ts2 = Ecto.DateTime.from_erl({{2016, 3, 23}, {10, 54, 19}})

    DataFactory.create(:metric, %{inserted_at: ts1})
    DataFactory.create(:metric, %{inserted_at: ts2})

    :ok
  end

  test "group_by_time(10, :minutes)" do
    result = MetricRepo.group_by_time(10, :minutes)

    assert Map.keys(result) == [1458729000, 1458730200]
  end

  test "group_by_time(3, :minutes)" do
    result = MetricRepo.group_by_time(3, :minutes)

    assert Map.keys(result) == [1458729180, 1458730440]
  end
end
