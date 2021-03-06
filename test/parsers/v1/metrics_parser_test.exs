defmodule Zhora.MetricsParserTest do
  use ExUnit.Case
  alias Zhora.MetricsParser

  test "simple parser" do
    result =
      ["app.request.200:mean 13.554",
       "app.request.200:median 13.554",
       "app.request.200:percentile_90 13.554",
       "app.request.200:min 13.554",
       "app.request.200:max 13.554",
       "app.request.200 1"]
      |> MetricsParser.parse

    expected =
      %{"app.request.200" =>
        %{"count" => 1, "mean" => 13.554, "median" => 13.554,
          "percentile_90" => 13.554, "min" => 13.554, "max" => 13.554}}

    assert result == expected
  end

  test "parser with variable keys" do
    result =
      ["app.request.200:mean 13.554",
       "app.request.200:median 13.554",
       "app.request.200:percentile_90 13.554",
       "app.request.200:min 13.554",
       "app.request.200:max 13.554",
       "app.request.200 1",
       "app.request.201:mean 10",
       "app.request.201:median 10",
       "app.request.201:percentile_90 10",
       "app.request.201:min 10",
       "app.request.201:max 10",
       "app.request.201 3",]
      |> MetricsParser.parse

    expected =
      %{"app.request.200" =>
        %{"count" => 1, "mean" => 13.554, "median" => 13.554,
          "percentile_90" => 13.554, "min" => 13.554, "max" => 13.554},
        "app.request.201" =>
        %{"count" => 3, "max" => 10.0, "mean" => 10.0, "median" => 10.0,
          "min" => 10.0, "percentile_90" => 10.0}}

    assert result == expected
  end

  test "parser without count" do
    result =
      ["app.request.200:min 13.554",
       "app.request.200:max 13.554"]
      |> MetricsParser.parse

    expected = %{"app.request.200" => %{"min" => 13.554, "max" => 13.554}}

    assert result == expected
  end

  test "parser with simple keys" do
    result =
      ["users 13",
       "users:valid 2",
       "requests 42.1"]
      |> MetricsParser.parse

    expected = %{"users" => %{"count" => 13, "valid" => 2.0}, "requests" => %{"count" => 42.1}}

    assert result == expected
  end

  test "parser with malformed values" do
    assert MetricsParser.parse(["users test"]) == {:error, "malformed value"}
  end

  test "parser with malformed keys" do
    assert MetricsParser.parse(["test"]) == {:error, "malformed metric"}
  end
end
