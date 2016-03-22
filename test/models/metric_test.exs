defmodule Zhora.MetricTest do
  use Zhora.ModelCase

  alias Zhora.Metric

  @valid_attrs %{project_id: "test", environment: "production", hostname: "zhora.io", metrics: %{"app.request.500" => %{"mean" => 13.554}}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Metric.changeset(%Metric{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Metric.changeset(%Metric{}, @invalid_attrs)
    refute changeset.valid?
  end
end
