defmodule Zhora.ApiV1PingTest do
  use Zhora.ConnCase

  test "POST /v1/ping with valid params", %{conn: conn} do
    conn = conn
    |> put_req_header("x-api-key", "aaaa1111")
    |> put_req_header("accept", "application/json")
    |> put_req_header("content-type", "application/json")
    |> post("/v1/ping",
        %{version: "2.5.3",
          framework: "Sinatra 1.4.7",
          environment: nil,
          hostname: "zhora.hoster",
          config: %{api_key: "aaaa1111"}})

    assert json_response(conn, 200) ==
      %{"features" => 
        %{"notices" => true,
          "local_variables" => true,
          "metrics" => true,
          "traces" => true,
          "feedback" => true},
        "limit" => false}
  end

  test "POST /v1/ping without params", %{conn: conn} do
    conn = conn
    |> put_req_header("x-api-key", "aaaa1111")
    |> post("/v1/ping")

    assert json_response(conn, 200) ==
      %{"features" => 
        %{"notices" => true,
          "local_variables" => true,
          "metrics" => true,
          "traces" => true,
          "feedback" => true},
        "limit" => false}
  end

  test "POST /v1/ping without api_key", %{conn: conn} do
    conn = post(conn, "/v1/ping")

    assert json_response(conn, 200) ==
      %{"features" => %{},
        "error" => "Invalid API key",
        "limit" => 0}
  end
end
